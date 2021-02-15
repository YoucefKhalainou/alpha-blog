
 <%= link_to "Edit", edit_article_path(article)%>
<%= link_to "Delete", article_path(article), method: :delete, data: {confirm: "Are you sure?"} %>
    <%= link_to "Create a new article", new_article_path%>   

 <%= link_to "Show", article_path(articles)%>
