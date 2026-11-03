# Cody VanZandt · Warm Literary

A Quarto website with a personal homepage, writing index, and a Markdown CV.
Production is published from `master` to GitHub Pages. The `quarto/warm-literary`
branch retains the migration work and design history.

## Local preview

Install Quarto. Homepage/CV rendering does not need R. Computational posts use R with `ggplot2 >= 4.0.0`, `ragg`, `systemfonts`, and `knitr`.

```text
quarto preview
```

```text
quarto render
```

Output is written to `_site/`, which is ignored by Git. Shared fonts are bundled with their licenses. No operating-system font installation is needed.

## Where to edit

- `index.qmd`: a pictureless introduction, the descriptor “Full-stack Bayesian data science,” and “Have priors, will travel.” with burgundy italic emphasis on “priors.” The name appears in the navigation; a compact two-paragraph bio and the most recent posts follow. Career and education details live in the CV.
- `cv/index.qmd`: the CV in one Markdown document, with year-only employment dates, education end years, ongoing master's study, and current methods/computing details.
- `writing/index.qmd`: all new writing, newest first, at `/writing/`. The old `/writing.html` address redirects here.
- `warm.scss`: shared typography, color, layout and CV styles over Litera.
- `R/plot-style.R`: the plotting theme, categorical and continuous scales, and lighter axis-label rendering.
- `_setup.qmd`: shared R setup for computational articles.

The homepage introduction uses full-size charcoal text for its opening paragraph and smaller muted text for the background and personal details. It has a single “Say hello ↗” email link below the bio and hides the duplicate email footer. Other pages keep the shared email footer. The English graduate-study entry describes study rather than implying a completed degree.

All pages share the same header. Home, Writing and CV stay visible; on phones,
the name sits above the navigation links. The active page has a burgundy underline.

The homepage and writing page have intentional empty states until the first new post is published. Quarto may warn that the empty listing glob matches no documents; that warning is expected until the first post exists. Archived posts are not listed.

## Create a post

From the project root:

```text
Rscript scripts/new-post.R my-first-post "A title with *a little emphasis*"
```

This creates `posts/my-first-post/index.qmd` without overwriting an existing folder. Or create that folder and copy `_templates/post.qmd` to `index.qmd` manually. The shared setup include is already in the template.

Edit the date, description, categories, introductory paragraph and article body. Title emphasis automatically becomes burgundy italic type. The first paragraph receives the larger opening treatment. Author ordinary Markdown and code; shared defaults handle fonts, figure dimensions, captions and code folding.

The example R chunk is marked `eval: false` until you replace its data import. Remove that option when the inputs are ready.

## Bring results from another analysis project

Keep exploratory work and expensive model fitting in the analysis project. Export the compact table or selected draws that the article needs, then copy those files into its post folder.

```r
# In the analysis project:
write.csv(group_results, "results.csv", row.names = FALSE)

# In posts/my-first-post/index.qmd:
results <- read.csv("posts/my-first-post/results.csv")
```

R executes from the website root. Paths inside a post therefore start with `posts/<slug>/`. Large model fits can stay in the analysis project; the article reads a stable publication snapshot.

```text
quarto preview posts/my-first-post/index.qmd
quarto render posts/my-first-post/index.qmd
quarto render
```

Explicitly rendering an article runs its code locally and updates `_freeze/`. Full project renders reuse frozen computations. Commit `_freeze/`, post source and necessary figure/data assets. Avoid fitting expensive models in a chunk that reruns during writing; read saved summaries instead.

For complex figures, per-chunk size settings are available. The lighter-label adapter is intended for ordinary Cartesian ggplots and is checked with facets, log/reversed scales, expressions and missing labels. To opt out for an extension plot, use `#| render: !expr knitr::knit_print`. Category colors are paired with shapes/line types where appropriate; the coordinated palette alone is not universally colorblind-safe.

## Archive

`archive/hugo-site/` preserves every originally tracked file from commit `debc11948ac66f3639a3ffcb5c6e936b451483d5`. It includes the four old blog posts, Dumb, Boring, Skeptical, dormant CV sections, and the old Hugo theme/assets. The archive is excluded from Quarto rendering and public resources.

## Publishing

Push to `master` to rebuild and publish https://codyvanzandt.com through GitHub Pages.
The `Publish Quarto website` workflow in `.github/workflows/publish.yml` pins Quarto
to 1.10.18, renders `_site/`, and deploys it using GitHub's Pages artifact workflow.
It can also be run manually from the repository's Actions tab. Other branches do
not publish automatically.

For a computational article, explicitly render that article locally first, then
commit its source, necessary assets and updated `_freeze/` results. The full-site
render on GitHub reuses these results without installing R, Python packages or
Stan. Preview locally before pushing. The built `_site/` directory stays ignored.

The repository's Pages source is GitHub Actions. Its custom domain and HTTPS are
configured in Settings → Pages; DNS is managed through the domain registrar.
Neither website builds nor hosting require Netlify. The original Netlify
configuration remains available in `archive/hugo-site/netlify.toml` for reference;
its retired DinnerDay redirect is not part of this site.
