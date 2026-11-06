```{=html}
<div class="editorial-posts">
<% for (const item of items) {
  const postPath = String(item.path).replace(/\\/g, '/').replace(/\/index\.(?:qmd|md|ipynb|html)$/, '/');
  // A post with no description gets a "<!-- desc(...) -->" placeholder from Quarto; treat it as empty.
  const description = String(item.description || '').startsWith('<!-- desc(') ? '' : item.description;
%>
<article class="quarto-post">
  <div class="post-date"><%- item.date ? new Date(item.date).toLocaleDateString('en-US', {month:'short',day:'numeric',year:'numeric',timeZone:'UTC'}) : '' %></div>
  <div class="post-body">
    <h3><a href="<%- postPath %>"><%- String(item.title || 'Untitled').replace(/\*([^*]+)\*/g, '$1') %></a></h3>
    <% if (description) { %><p><%- description %></p><% } %>
  </div>
</article>
<% } %>
</div>
```
