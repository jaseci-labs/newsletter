import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIContext } from 'astro';

export const prerender = true;

export async function GET(context: APIContext) {
  const issues = (await getCollection('issues', ({ data }) => !data.draft)).sort(
    (a, b) => b.data.number - a.data.number
  );

  return rss({
    title: 'Jaseci Digest',
    description:
      'A biweekly digest of the Jaseci & Jac open-source ecosystem: releases, articles, talks, and community highlights.',
    site: context.site ?? 'https://jasecidigest.com',
    items: issues.map((issue) => ({
      title: `Issue N.${String(issue.data.number).padStart(2, '0')}: ${issue.data.title}`,
      description: issue.data.description,
      pubDate: issue.data.date,
      link: `/issues/${issue.slug}/`,
    })),
  });
}
