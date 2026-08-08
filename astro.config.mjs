import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://jasecidigest.com',
  markdown: {
    shikiConfig: {
      theme: 'github-dark-dimmed',
      wrap: true,
    },
  },
});
