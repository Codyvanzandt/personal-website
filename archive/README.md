# Archived Hugo site

`hugo-site/` preserves the complete original tracked site at commit
`debc11948ac66f3639a3ffcb5c6e936b451483d5` (Streamlining homepage).

This includes the four old blog posts, the standalone Dumb, Boring, Skeptical HTML document, original CV/homepage sources, assets, theme configuration, and the old DinnerDay redirect configuration. They are kept for reference in Git and are not part of the Quarto website.

Quarto explicitly excludes this directory from rendering. Only fonts and current homepage images are declared as public project resources. There are no navigation links to this archive.

The root `netlify.toml` remains byte-for-byte unchanged while this branch is reviewed; the complete original is also preserved here. Netlify migration and removal of its legacy DinnerDay redirect are intentionally deferred to the deployment step.
