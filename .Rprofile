# Project helpers. Loaded automatically when R starts in this folder.

new_post <- function(title, slug = NULL) {
  stopifnot(file.exists("_quarto.yml"))
  if (is.null(slug)) {
    slug <- tolower(gsub("[^A-Za-z0-9]+", "-", gsub("[*_`]", "", title)))
    slug <- gsub("^-+|-+$", "", slug)
  }
  dir <- file.path("posts", slug)
  if (dir.exists(dir)) stop(dir, " already exists; nothing was overwritten.")
  lines <- readLines("_templates/post.qmd", warn = FALSE, encoding = "UTF-8")
  lines[grepl("^title:", lines)] <- paste0("title: ", encodeString(title, quote = '"'))
  lines[grepl("^date:", lines)] <- paste0("date: ", format(Sys.Date(), "%Y-%m-%d"))
  lines <- gsub("posts/your-post/", paste0(dir, "/"), lines, fixed = TRUE)
  dir.create(dir, recursive = TRUE)
  path <- file.path(dir, "index.qmd")
  writeLines(enc2utf8(lines), path, useBytes = TRUE)
  file.edit(path)
  invisible(path)
}

# Re-run a post's code and refresh _freeze/ (commit it before publishing).
render_post <- function(slug) {
  quarto <- Sys.which("quarto")
  if (!nzchar(quarto)) stop("quarto not found on PATH.")
  system2(quarto, c("render", file.path("posts", slug, "index.qmd")))
}
