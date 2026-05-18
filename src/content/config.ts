import { defineCollection, z } from 'astro:content';

const issues = defineCollection({
  type: 'content',
  schema: z.object({
    number: z.number(),
    title: z.string(),
    date: z.coerce.date(),
    description: z.string(),
    draft: z.boolean().default(false),
  }),
});

// Long-form articles linked from issue Featured items. Not listed in the
// /issues archive; only reachable by direct URL.
const articles = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    eyebrow: z.string().optional(),
    draft: z.boolean().default(false),
  }),
});

export const collections = { issues, articles };
