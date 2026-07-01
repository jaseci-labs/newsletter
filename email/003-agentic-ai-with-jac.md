<style>@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');</style>

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background:#ffffff;margin-bottom:24px;">
<tr>
<td align="center" style="padding: 20px 24px 0;">
<a href="https://newsletter.jaseci.org" style="text-decoration:none;color:#1f160e;display:inline-block;">
<img src="https://newsletter.jaseci.org/logo.png" width="28" height="28" alt="" style="vertical-align:middle;border:0;display:inline-block;">
<span style="display:inline-block;margin-left:8px;text-transform:uppercase;letter-spacing:0.18em;font-size:13px;font-weight:600;vertical-align:middle;color:#1f160e;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">Jaseci Digest &middot; July 1, 2026</span>
</a>
</td>
</tr>
<tr>
<td style="padding: 0 24px;">
<div style="height:1px;background:#1f160e;line-height:1px;font-size:1px;margin:16px 0 0;">&nbsp;</div>
</td>
</tr>
</table>

Welcome to **Issue N.03** of [Jaseci Digest](https://newsletter.jaseci.org), a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

**This issue's lead:** building an AI agent is mostly scaffolding, not the agent. [Building Agentic AI with Jac](https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac) shows how Jac builds that scaffolding into the language, so the only code you write is the agent itself.

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:38px auto 6px;"><tr><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td><td valign="middle" align="center" style="padding:0 12px;"><img src="https://newsletter.jaseci.org/logo.png" width="24" height="24" alt="" style="display:block;border:0;"></td><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td></tr></table> <!--secdiv-->

<h2 style="text-align:center;font-family:'Kaushan Script','Brush Script MT','Segoe Script',cursive;font-size:40px;font-weight:700;color:#ff6b35;text-transform:none;letter-spacing:0;line-height:1.05;margin:4px 24px 10px;">Featured</h2>

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin: 16px 0 24px;">
  <tr>
    <td style="border:1px solid rgba(31,22,14,0.18);background:#ece7db;padding:22px 22px 24px;border-radius:4px;">

      <a href="https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac" style="text-decoration:none;color:#160f0a;display:block;"><strong style="display:block;font-size:24px;font-weight:700;text-transform:uppercase;color:#160f0a;margin:2px 0 14px;letter-spacing:-0.01em;line-height:1.14;">Agentic AI is easy when it's built into the language</strong></a>

      <p style="margin:0 0 16px;font-size:17px;font-weight:700;line-height:1.4;color:#160f0a;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">What if building an AI agent took <span style="color:#ff6b35;">10x fewer lines of code</span> than Python? In Jac, the whole thing is just <span style="color:#ff6b35;">7 lines</span>.</p>

      <a href="https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac" target="_blank" rel="noopener" style="display:block;text-decoration:none;color:inherit;"><table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0;">
        <tr><td style="background:#efdcc4;border:1px solid rgba(31,22,14,0.18);border-bottom:none;border-radius:8px 8px 0 0;padding:10px 14px;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0"><tr>
            <td style="font-size:13px;font-weight:700;color:#160f0a;">A complete AI agent</td>
            <td align="right"><span style="display:inline-block;background:#ff6b35;color:#f3efe6;font-size:11px;font-weight:700;text-transform:uppercase;letter-spacing:0.05em;padding:3px 10px;border-radius:999px;">7 lines of Jac</span></td>
          </tr></table>
        </td></tr>
      </table>
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 18px;">
        <tr><td style="background:#ffffff;border:1px solid rgba(31,22,14,0.18);border-top:none;border-radius:0 0 8px 8px;padding:15px 16px;font-family:'SFMono-Regular',Consolas,'Courier New',monospace;font-size:13px;font-weight:600;line-height:1.65;color:#241c12;">
<span style="color:#8a3fb0;">import</span> <span style="color:#8a3fb0;">from</span> .tools { web_search, read_file, write_file }<br>
<br>
<span style="color:#a87431;font-style:italic;"># An agent: a function the model runs, calling tools.</span><br>
<span style="color:#8a3fb0;">def</span> research(topic: <span style="color:#1f7a70;">str</span>) -&gt; <span style="color:#1f7a70;">str</span> <span style="color:#8a3fb0;">by</span> llm(<br>
&nbsp;&nbsp;&nbsp;&nbsp;tools=[web_search, read_file, write_file]<br>
);<br>
<br>
<span style="color:#8a3fb0;">with</span> entry {<br>
&nbsp;&nbsp;&nbsp;&nbsp;print(research(<span style="color:#b5432c;">"the best coffee in Tokyo"</span>));<br>
}
        </td></tr>
      </table></a>

      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:4px 0 6px;">
        <tr><td style="background:#ece7db;border:1px solid rgba(31,22,14,0.18);border-radius:10px;padding:13px 16px;font-size:14px;line-height:1.5;color:#6a5f50;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">
          <span style="display:block;font-weight:700;font-size:11px;text-transform:uppercase;letter-spacing:0.05em;color:#6a5f50;margin-bottom:5px;">&#10007;&nbsp; The usual way</span>
          You write the agent and all the code around it: each tool's JSON schema, a dispatch table, the loop that runs while the model works, and the validating and retrying of its output. The same agent in Python runs to around 70 lines, and most of it is not the agent.
        </td></tr>
      </table>
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 0 18px;">
        <tr><td style="background:#fbe7da;border:1px solid rgba(31,22,14,0.18);border-radius:10px;padding:13px 16px;font-size:15px;line-height:1.5;color:#1f160e;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">
          <span style="display:block;font-weight:700;font-size:11px;text-transform:uppercase;letter-spacing:0.05em;color:#ff6b35;margin-bottom:5px;">&#10003;&nbsp; With Jac</span>
          <strong style="color:#160f0a;">That supporting code is part of the language.</strong> You describe the agent, and the runtime handles the rest. The whole thing is the 7 lines above.
        </td></tr>
      </table>

      <p style="margin:0 0 14px;font-size:14px;line-height:1.55;color:#1f160e;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">The full article explores how Jac makes building real, capable agents this simple.</p>

      <table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center" style="margin:2px auto 2px;">
        <tr><td style="border-radius:999px;background:#ff6b35;">
          <a href="https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac" target="_blank" rel="noopener" style="display:inline-block;padding:13px 30px;text-decoration:none;color:#f3efe6 !important;text-transform:uppercase;letter-spacing:0.06em;font-size:14px;font-weight:700;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">Read the article &rarr;</a>
        </td></tr>
      </table>

    </td>
  </tr>
</table>

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:38px auto 6px;"><tr><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td><td valign="middle" align="center" style="padding:0 12px;"><img src="https://newsletter.jaseci.org/logo.png" width="24" height="24" alt="" style="display:block;border:0;"></td><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td></tr></table> <!--secdiv-->

## Tutorials

### [Jac Tutorial: Lesson 1](https://youtu.be/EB4vtXbO5Js)

The Jaseci team just kicked off a video series that teaches Jac from the ground up. Lesson 1 is a hands-on introduction: install the toolchain, write your first program, and get a feel for how the language reads. It is the first of many, with new lessons landing regularly, so subscribe to the Jaseci channel to follow along.

<table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center" style="margin:12px auto 14px;">
  <tr><td style="border-radius:999px;background:#ff0000;">
    <a href="https://www.youtube.com/@Jac-Jaseci" target="_blank" rel="noopener" style="display:inline-block;padding:11px 26px;text-decoration:none;color:#ffffff !important;font-size:14px;font-weight:700;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">&#9658;&nbsp;&nbsp;Subscribe to Jaseci on YouTube</a>
  </td></tr>
</table>

<a href="https://www.youtube.com/watch?v=EB4vtXbO5Js" target="_blank" rel="noopener" style="text-decoration:none;display:block;">
  <img src="https://i.ytimg.com/vi/EB4vtXbO5Js/maxresdefault.jpg" width="100%" alt="Watch Jac Tutorial: Lesson 1 on YouTube" style="display:block;border:1px solid rgba(31,22,14,0.18);border-radius:8px;width:100%;max-width:100%;height:auto;">
</a>

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:38px auto 6px;"><tr><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td><td valign="middle" align="center" style="padding:0 12px;"><img src="https://newsletter.jaseci.org/logo.png" width="24" height="24" alt="" style="display:block;border:0;"></td><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td></tr></table> <!--secdiv-->

## Community

### [JacHacks SF is coming](https://jachacks.org/)

<a href="https://jachacks.org/" target="_blank" rel="noopener" style="text-decoration:none;display:block;">
  <img src="https://newsletter.jaseci.org/issues/003/jachacks.png?v=2" width="100%" alt="JacHacks SF. July 26, 2026, 8:00 AM PT, Founders, Inc., San Francisco." style="display:block;border:1px solid rgba(31,22,14,0.18);border-radius:8px;width:100%;max-width:100%;height:auto;margin:6px 0 14px;">
</a>

JacHacks heads to San Francisco for a one-day, in-person hackathon built around the future of AI programming, landing **July 26 at 8 AM PT** at **Founders, Inc.** It follows a strong run for the series, with JacHacks Spring drawing **300+ builders** and **81 projects** online this May.

<table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center" style="margin:12px auto 16px;">
  <tr><td style="border-radius:999px;background:#ff6b35;">
    <a href="https://jachacks.org/" target="_blank" rel="noopener" style="display:inline-block;padding:12px 28px;text-decoration:none;color:#f3efe6 !important;text-transform:uppercase;letter-spacing:0.05em;font-size:14px;font-weight:700;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">Register for JacHacks SF</a>
  </td></tr>
</table>

### [Join the Jaseci Discord](https://discord.com/invite/6j3QNdtcN6)

The fastest way to talk to the team and other builders. RFC chatter, debugging help, release questions, and a steady stream of show-and-tells. Worth joining whether you ship in production or are just curious.

<table role="presentation" cellpadding="0" cellspacing="0" border="0" align="center" style="margin:12px auto 16px;">
  <tr><td style="border-radius:999px;background:#5865F2;">
    <a href="https://discord.com/invite/6j3QNdtcN6" target="_blank" rel="noopener" style="display:inline-block;padding:12px 28px;text-decoration:none;color:#ffffff !important;font-size:14px;font-weight:700;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">Join the Discord</a>
  </td></tr>
</table>

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:38px auto 6px;"><tr><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td><td valign="middle" align="center" style="padding:0 12px;"><img src="https://newsletter.jaseci.org/logo.png" width="24" height="24" alt="" style="display:block;border:0;"></td><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td></tr></table> <!--secdiv-->

## Articles

### [What 75 students shipped in one semester with Jac](https://cse.engin.umich.edu/stories/students-build-agentic-ai-tools-for-work-travel-wellness)

Over one Winter semester, 75+ students in Michigan's EECS 449 shipped 17 full-stack AI applications, most of them in Jac. These were real, working products, not chatbot demos, from an adaptive scheduling assistant to a research terminal for prediction-market traders. They got there in a single term because Jac handles the interface, the logic, the data, and the AI in one language, so the teams spent their time building instead of wiring tools together.

<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:38px auto 6px;"><tr><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td><td valign="middle" align="center" style="padding:0 12px;"><img src="https://newsletter.jaseci.org/logo.png" width="24" height="24" alt="" style="display:block;border:0;"></td><td valign="middle" style="width:44%;"><div style="border-top:1px solid rgba(31,22,14,0.22);height:1px;line-height:1px;font-size:1px;">&nbsp;</div></td></tr></table> <!--secdiv-->

## Releases

### [jaclang v0.30.3: one self-contained binary, nothing else to install](https://docs.jaseci.org/community/release_notes/jaclang/)

The headline of the 0.30 series: jaclang now ships as a single self-contained `jac` binary, a Zig launcher with a bundled CPython. It runs without a separate Python installation or a package manager. Download the binary, add it to your PATH, and `jac run` and `jac start` work immediately. Serving and deploying are now built in as well, with the former `jac-scale` package folded into the binary, and Jac-native desktop apps run on that same bundled runtime. Heavier dependencies such as FastAPI, MongoDB, and Redis are installed per project, only when your configuration requires them.

<div style="text-align:center;margin:48px 0 16px;">
<a href="https://newsletter.jaseci.org/issues" style="display:inline-block;padding:14px 32px;border:1.5px solid #ff6b35;background:#ffffff;text-decoration:none;border-radius:999px;"><span style="text-transform:uppercase;letter-spacing:0.08em;font-size:14px;font-weight:600;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">Browse the archive</span></a>
</div>

<!-- BRAND FOOTER (rule + copyright + logo). Buttondown auto-appends the unsubscribe block below this. -->
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" style="background:#ffffff;margin-top:32px;">
<tr>
<td style="padding: 0 24px;">
<div style="height:1px;background:#d8d2c6;line-height:1px;font-size:1px;margin:0 0 16px;">&nbsp;</div>
</td>
</tr>
<tr>
<td style="padding: 0 24px 8px;">
<div style="display:inline-block;padding-top:8px;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">
<div style="text-transform:uppercase;letter-spacing:0.12em;font-size:12px;font-weight:600;color:#6a5f50;">Issue N.03 &middot; July 1, 2026</div>
<div style="margin-top:2px;"><a href="https://newsletter.jaseci.org" style="text-transform:uppercase;letter-spacing:0.1em;font-size:13px;font-weight:600;text-decoration:none;">Jaseci Digest</a></div>
</div>
</td>
</tr>
<tr>
<td style="padding: 8px 24px 24px;">
<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0">
<tr>
<td valign="middle" style="font-size:13px;color:#6a5f50;letter-spacing:0.02em;font-family:'Inter','Helvetica Neue',Arial,sans-serif;">&copy; 2026 Jaseci Digest. Part of the Jaseci open-source ecosystem.</td>
<td valign="middle" align="right" style="width:60px;">
<a href="https://www.jaseci.org" target="_blank" rel="noopener" style="text-decoration:none;">
<img src="https://newsletter.jaseci.org/logo.png" width="40" height="40" alt="Jaseci" style="border:0;display:block;">
</a>
</td>
</tr>
</table>
</td>
</tr>
</table>
