```{=html}
<div class="editorial-posts">
<% for (const item of items) { %>
<article class="quarto-post">
  <div class="post-date"><%- item.date ? new Date(item.date).toLocaleDateString('en-US', {month:'short',day:'numeric',year:'numeric',timeZone:'UTC'}) : '' %></div>
  <div class="post-body">
    <h3><a href="<%- item.path %>"><%- String(item.title || 'Untitled').replace(/\*([^*]+)\*/g, '$1') %></a></h3>
    <% if (item.description) { %><p><%- item.description %></p><% } %>
  </div>
</article>
<% } %>
</div>
```
