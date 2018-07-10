<cfquery name="getBlogs">
    SELECT * FROM dbo.[Blog] ORDER BY [blogCreatedDate] DESC
</cfquery>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--- style sheets --->
    <link rel="stylesheet" type="text/css" href="/src/styles/blogs.css">

</head>

<body width="1500px">
    <h2 align="center">Here are some more blogs by other members</h2>
    <cfinclude template="/src/pages/headerinfo.cfm">
    <div class="new-blog-link">
        Click <a href="/src/pages/addBlog.cfm">here</a> to add a new blog.
    </div>
    <div align="center" id="blog-list-container">
        <cfloop query="getBlogs">
            <cfoutput>
                <div align="left">
                    <h3 class="date-header">#dateFormat(getBlogs.blogCreatedDate, "ddd, mmmm dd, yyyy")#</h3><span class="blog-owner"> <i>By #session.user#</i><br/></span>
                    <span class="blog-title">#getBlogs.blogTitle#</span>
                    <div class="blog-content">#getBlogs.blogContent#</div><br><br>
                </div>
            </cfoutput>
        </cfloop>
    </div>
</body>
</html>