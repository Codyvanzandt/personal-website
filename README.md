# Website notes

Quarto site, published to https://codyvanzandt.com from `master` via GitHub Pages
(`.github/workflows/publish.yml`). Edit in Positron.

## Write a post

In the R console (project root):

```r
new_post("A title with *emphasis*")   # creates posts/a-title-with-emphasis/index.qmd and opens it
```

Edit the description, categories and body. Preview with the Quarto Preview button
(Ctrl+Shift+K) on the open file.

## Posts with R code

- Put data the post needs in `posts/<slug>/` and read it as `posts/<slug>/file.csv`
  (R runs from the site root). Keep expensive model fits in the analysis project;
  export a compact summary.
- Before publishing, run `render_post("<slug>")` (or the Render button) to refresh `_freeze/`.
  GitHub's build reuses frozen results and does not run R.

## Publish

Commit the post, its assets and `_freeze/`, then push `master`. Check the Actions tab if
the site doesn't update. `quarto render` builds locally into `_site/` (git-ignored).

## Where things live

- `index.qmd`: homepage. `writing/index.qmd`: post listing. `cv/index.qmd`: CV.
- `posts/`: one folder per post. `_templates/post.qmd`: new-post template.
- `warm.scss`: typography and colors. `R/plot-style.R`, `_setup.qmd`: plot theme and shared R setup.
- `archive/hugo-site/`: the old Hugo site, kept for reference; not rendered.
