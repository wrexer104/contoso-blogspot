<cfparam name = "pageNumber" default = "1" />
<!--- <cfset blogId=url.blogId />

<cfquery name="getSingleBlog">
    SELECT
    *
    FROM
        (
            SELECT
                ROW_NUMBER () OVER (ORDER BY blogCreatedDate DESC) AS RowNum,
                *
            FROM
                dbo.[Blog]
        ) sub
    WHERE
        RowNum = #blogId#;

</cfquery> --->
<cfif structKeyExists(url, "page")>
    <cfset pageNumber = url.page />
</cfif>

<cfset oBlogCount = createobject("component", "src.components.blogCount") />
<cfset blogCount = oBlogCount.getTotalBlogCount() />

<cfset pageSize = 5 />

<cfquery name="listBlogPages">
    SELECT u.username, b.blogTitle, b.blogContent, b.blogCreatedDate
    FROM dbo.[User] u FULL OUTER JOIN dbo.[Blog] b ON u.id = b.userId 
    ORDER BY [blogCreatedDate] DESC
    OFFSET #pageSize# * (#pageNumber# - 1) ROWS
    FETCH NEXT #pageSize# ROWS ONLY;
</cfquery>

<cfquery name="getTotalBlogs">
    select * from dbo.[Blog] ORDER BY blogCreatedDate;
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

<body>
    <h2 align="center">Here are some more blogs by other members</h2>
    <cfinclude template="/src/pages/headerinfo.cfm">
    <div class="new-blog-link">
        Click <a href="/src/pages/addBlog.cfm">here</a> to add a new blog.
    </div>
    <div width="1200px" align="left" id="blog-list-container">
        <cfset counter = pageSize - 1 />
        
        <cfloop query="listBlogPages">
            <cfoutput>
                <p>
                    <cfset blogNumber = pagesize * pageNumber - counter />
                    <h3 class="date-header">#dateFormat(listBlogPages.blogCreatedDate, "ddd, mmmm dd, yyyy")#</h3><span class="blog-owner"> <i>By #listBlogPages.username#</i><br/></span>
                    <span><a href="/src/pages/displayBlog.cfm?blogId=#blogNumber#" class="blog-title">#blogNumber#. #listBlogPages.blogTitle#</a></span>
                    <cfset counter = counter - 1 />
                </p><br><br>
            </cfoutput>
        </cfloop>
    </div>

    <nav align="center">
        <ul class="pagination">
            <cfoutput>
                <li class="page-item"><a class="page-link" href=<cfif pageNumber GT 1>"/src/pages/listBlogs.cfm?page=#pageNumber-1#" </cfif>>Previous</a></li>
            </cfoutput>

            <cfoutput>
                <cfloop from="1" to="#blogCount#" index="i">
                    <li class="page-item"><a class="page-link page-number" href="/src/pages/listBlogs.cfm?page=#i#" >#i#</a></li>
                </cfloop>
            </cfoutput>
            <cfoutput>
                <li class="page-item"><a class="page-link" href=<cfif blogNumber LT #blogCount#>"/src/pages/listBlogs.cfm?page=#pageNumber+1#" </cfif>>Next</a></li>
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
</html>