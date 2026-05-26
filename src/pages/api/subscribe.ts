import type { APIRoute } from 'astro';

export const prerender = false;

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const BUTTONDOWN_SUBSCRIBERS_URL = 'https://api.buttondown.email/v1/subscribers';
const BUTTONDOWN_EMAILS_URL = 'https://api.buttondown.email/v1/emails';

// Welcome email — sent immediately after a successful single-opt-in subscribe.
// Edit subject/body here; markdown is fine.
const WELCOME_SUBJECT = 'Welcome to Jaseci Digest';
const WELCOME_BODY = `Hey,

Thanks for subscribing to **Jaseci Digest**, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

**What to expect**

- **One issue every other Tuesday.** Releases, articles, JacHacks projects, talks, RFCs, and the occasional deep dive.
- **No spam.** Unsubscribe anytime. Every email has a one-click link at the bottom.
- **Worth your time.** Nothing goes out until it clears the editor's bar.

**Before the first issue lands, a few things to explore**

- Browse [past issues](https://jasecidigest.com/issues)
- Check out [jaseci.org](https://www.jaseci.org)
- Join the [Jaseci Discord](https://discord.gg/jaseci). Most of the ecosystem conversation lives there.

Got something we should cover? Just reply to this email. It lands in the editor's inbox.

Thanks,
The Jaseci Digest team`;

function json(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: { 'Content-Type': 'application/json' },
  });
}

// Active subscriber types in Buttondown. Anything else (`unsubscribed`,
// `removed`, `spammed`, `complained`) means the address is NOT currently
// receiving the newsletter and must not be silently treated as a happy duplicate.
const ACTIVE_SUBSCRIBER_TYPES = new Set(['regular', 'unactivated', 'gifted']);

async function getSubscriberType(apiKey: string, email: string): Promise<string | null> {
  try {
    const response = await fetch(
      `${BUTTONDOWN_SUBSCRIBERS_URL}/${encodeURIComponent(email)}`,
      { headers: { Authorization: `Token ${apiKey}` } },
    );
    if (!response.ok) return null;
    const data = (await response.json().catch(() => ({}))) as { type?: unknown };
    return typeof data.type === 'string' ? data.type : null;
  } catch {
    return null;
  }
}

async function sendWelcomeEmail(
  apiKey: string,
  email: string,
  welcomeToken: string,
): Promise<void> {
  try {
    // Buttondown rejects emails whose subject+body matches a previously-created
    // email as `email_duplicate`. Append an invisible HTML comment so each
    // transactional welcome is unique to dedup but visually identical to readers.
    const body = `${WELCOME_BODY}\n\n<!-- welcome:${email}:${Date.now()} -->`;

    // CRITICAL: Buttondown's email-create endpoint determines recipients via
    // `filters`, NOT the (read-only) `subscribers` field. An empty filters
    // block broadcasts to ALL subscribers. Buttondown's filters can target
    // `subscriber.tags`, `subscriber.status`, `subscriber.metadata.<key>`,
    // etc. — but NOT email_address directly. So we stamp each new subscriber
    // with a unique `metadata.welcome_token` and filter on that, guaranteeing
    // exactly one recipient.
    const response = await fetch(BUTTONDOWN_EMAILS_URL, {
      method: 'POST',
      headers: {
        Authorization: `Token ${apiKey}`,
        'Content-Type': 'application/json',
        // Required to create emails with status 'about_to_send' via API.
        'X-Buttondown-Live-Dangerously': 'true',
      },
      body: JSON.stringify({
        subject: WELCOME_SUBJECT,
        body,
        email_type: 'private',
        status: 'about_to_send',
        filters: {
          filters: [
            {
              field: 'subscriber.metadata.welcome_token',
              operator: 'equals',
              value: welcomeToken,
            },
          ],
          groups: [],
          predicate: 'and',
        },
      }),
    });

    if (!response.ok) {
      const detail = await response.text().catch(() => '');
      console.error('[subscribe] welcome email failed', response.status, detail);
    }
  } catch (err) {
    console.error('[subscribe] welcome email network error', err);
  }
}

export const POST: APIRoute = async ({ request }) => {
  let email = '';

  const contentType = request.headers.get('content-type') ?? '';
  try {
    if (contentType.includes('application/json')) {
      const body = await request.json();
      email = String(body?.email ?? '').trim();
    } else {
      const form = await request.formData();
      email = String(form.get('email') ?? '').trim();
    }
  } catch {
    return json({ error: 'Could not read request body.' }, 400);
  }

  if (!email || !EMAIL_RE.test(email) || email.length > 254) {
    return json({ error: 'Please enter a valid email address.' }, 400);
  }

  const apiKey = import.meta.env.BUTTONDOWN_API_KEY;
  if (!apiKey) {
    console.error('[subscribe] BUTTONDOWN_API_KEY is not set');
    return json({ error: 'Subscription is temporarily unavailable.' }, 500);
  }

  // Unique per-subscribe token used to target the welcome email at exactly
  // this subscriber (see sendWelcomeEmail). Stored on the subscriber's
  // metadata so Buttondown's filter API can match it.
  const welcomeToken = crypto.randomUUID();

  let response: Response;
  try {
    response = await fetch(BUTTONDOWN_SUBSCRIBERS_URL, {
      method: 'POST',
      headers: {
        Authorization: `Token ${apiKey}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        email_address: email,
        type: 'regular',
        metadata: {
          source: 'jaseci-digest-site',
          welcome_token: welcomeToken,
        },
      }),
    });
  } catch (err) {
    console.error('[subscribe] network error calling Buttondown', err);
    return json({ error: 'Could not reach the email service. Try again in a moment.' }, 502);
  }

  if (response.ok) {
    // Fire the welcome email. Awaited so we know if it failed (logged),
    // but its failure does NOT fail the subscribe — they're already on the list.
    await sendWelcomeEmail(apiKey, email, welcomeToken);
    return json({ ok: true });
  }

  // Buttondown returns 400 with a structured error for known cases (already subscribed, banned, etc.).
  const errorBody = await response.json().catch(() => ({}) as Record<string, unknown>);
  const code = String((errorBody as any)?.code ?? '');
  const detail = String((errorBody as any)?.detail ?? '');

  if (code === 'email_already_exists' || /already.*subscribed|already exists/i.test(detail)) {
    // Buttondown returns this for ANY pre-existing record — including users
    // who've since unsubscribed. Check their current type before claiming
    // "you're already on the list."
    const currentType = await getSubscriberType(apiKey, email);
    if (currentType && ACTIVE_SUBSCRIBER_TYPES.has(currentType)) {
      return json({ ok: true, alreadySubscribed: true });
    }
    return json(
      {
        error:
          "This email previously unsubscribed and can't be resubscribed automatically. If this was a mistake, email us and we'll sort it out.",
      },
      400,
    );
  }

  if (code === 'subscriber_suppressed') {
    // Buttondown's suppression list — the address previously unsubscribed or
    // marked as spam. We can't and should not silently re-add them.
    return json(
      {
        error:
          "This email previously unsubscribed and can't be resubscribed automatically. If this was a mistake, email us and we'll sort it out.",
      },
      400,
    );
  }

  console.error('[subscribe] buttondown error', response.status, code, detail);
  return json({ error: 'Something went wrong. Please try again.' }, 502);
};
