<cfset blogId=url.blogId />

<cfquery name="getSingleBlog">
    SELECT
    *
    FROM
        (
            SELECT
                ROW_NUMBER () OVER (ORDER BY blogCreatedDate DESC) AS RowNum,
                *
            FROM
                dbo.[Blog] JOIN dbo.[User] ON dbo.[Blog].userId = dbo.[User].id
        ) sub
    WHERE
        RowNum = #blogId#;

</cfquery>

<cfset oBlogCount = createobject("component", "src.components.blogCount") />
<cfset blogCount = oBlogCount.getTotalBlogCount() />

<cfquery name="getBlogDetail">
    select u.username, b.blogTitle, b.blogContent, b.blogCreatedDate
    from dbo.[User] u JOIN dbo.[Blog] b ON u.id = b.userId 
    ORDER BY blogCreatedDate DESC;
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
    <!--- comment box--->
    <link rel="stylesheet" type="text/css" href="//www.htmlcommentbox.com/static/skins/bootstrap/twitter-bootstrap.css?v=0" />
        

</head>

<body>
    <cfoutput>
        <h2 align="center">Blog by #getSingleBlog.username#</h2>
    </cfoutput>
    <cfinclude template="/src/pages/headerinfo.cfm">
    <div class="new-blog-link">
        Click <a href="/src/pages/addBlog.cfm">here</a> to add a new blog.
    </div>
    <div align="center" id="blog-list-container">
        <cfloop query="getSingleBlog">
            <cfoutput>
                <div align="left">
                    <h3 class="date-header">#dateFormat(getSingleBlog.blogCreatedDate, "ddd, mmmm dd, yyyy")#</h3><span class="blog-owner"> <i>By #getSingleBlog.username#</i><br/></span>
                    <span class="blog-title">#getSingleBlog.blogTitle#</span>
                    <div class="blog-content">#getSingleBlog.blogContent#</div><br><br>
                </div>
            </cfoutput>
        </cfloop>
    </div>
    
    <div id="HCB_comment_box" width="1200px">Loading comments...</div>
    
    <p class="new-blog-link">
        Click <a href="/src/pages/listBlogs.cfm">here</a> to go back to the blog list page.
    </p>

    <nav align="center">
        <ul class="pagination">
            <cfoutput>
                <li class="page-item"><a class="page-link" href=<cfif blogId GT 1>"/src/pages/displayBlog.cfm?blogId=#blogId-1#" </cfif>><<</a></li>
            </cfoutput>

            <cfoutput>
                <cfloop from="1" to="#blogCount#" index="i">
                    <li class="page-item"><a class="page-link page-number" href="/src/pages/displayBlog.cfm?blogId=#i#" onclick='clickPage(this)'>#i#</a></li>
                </cfloop>
            </cfoutput>
            <cfoutput>
                <li class="page-item"><a class="page-link" href=<cfif blogId LT #blogCount#>"/src/pages/displayBlog.cfm?blogId=#blogId+1#" </cfif>>>></a></li>
            </cfoutput>
        </ul>
    </nav>
    
</body>
<script type="text/javascript">
    function clickPage(obj){
        var pageNum = jQuery(obj).text();
        return pageNum;
    }
            
</script>

    <script type="text/javascript" id="hcb"> 
    /*<!--*/ if(!window.hcb_user){hcb_user={};} (function() { 
        var s=document.createElement("script"), l=hcb_user.PAGE || (""+window.location).replace(/'/g,"%27"), h="//www.htmlcommentbox.com";
        s.setAttribute("type","text/javascript");
        s.setAttribute("src", h+"/jread?page="+encodeURIComponent(l).replace("+","%2B")+"&opts=16862&num=10&ts=1533587575091");
        if (typeof s!="undefined") 
            document.getElementsByTagName("head")[0].appendChild(s);
        })(); /*-->*/ 
    </script>
</html>

<!---  OFFSET 100 ROWS FETCH NEXT 5 ROWS ONLY --->