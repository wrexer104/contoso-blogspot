<cfparam name = "pageNumber" default = "1" />
<cfparam name="formSearchValue" default="" />
<cfset searchCount = 0>


<cfif structKeyExists(url, "page")>
    <cfset pageNumber = url.page />
</cfif>

<cfset oBlog = createobject("component", "src.components.blog") />
<cfset blogCount = oBlog.getTotalBlogCount() />

<cfset pageSize = 5 />

<cfif isDefined("search") AND len(trim(form.inputData)) GT 0>
    <cfset formSearchValue = form.inputData>
    <cfquery name="listBlogPages">
        DECLARE @InputData varchar(max) = <cfqueryparam cfsqltype="cf_sql_varchar" value="%#formSearchValue#%">
        SELECT username, blogTitle, blogContent, blogCreatedDate FROM dbo.Blog INNER JOIN dbo.[User] 
        ON dbo.[User].id = dbo.Blog.userId WHERE blogTitle like @InputData
        or blogContent like @InputData
        or username like @InputData
        ORDER BY [blogCreatedDate] DESC
        -- OFFSET #pageSize# * (#pageNumber# - 1) ROWS
        -- FETCH NEXT #pageSize# ROWS ONLY;
    </cfquery>
    <cfset searchCount = listBlogPages.recordCount>
<cfelse>
    <cfset formSearchValue = "">
    <cfquery name="listBlogPages">
        SELECT u.username, b.blogTitle, b.blogContent, b.blogCreatedDate
        FROM dbo.[User] u FULL OUTER JOIN dbo.[Blog] b ON u.id = b.userId 
        ORDER BY [blogCreatedDate] DESC
        OFFSET #pageSize# * (#pageNumber# - 1) ROWS
        FETCH NEXT #pageSize# ROWS ONLY;
    </cfquery>
</cfif>

<cfquery name="getTotalBlogs">
    select * from dbo.[Blog] ORDER BY blogCreatedDate;
</cfquery>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- icon library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!--- style sheets --->
    <link rel="stylesheet" type="text/css" href="/src/styles/blogs.css">

</head>

<body>
    <cfoutput>
        <h2 align="center">Here are some more blogs by other members</h2>
        <cfinclude template="/src/pages/headerinfo.cfm">
        <div class="new-blog-link">
            Click <a href="/src/pages/addBlog.cfm">here</a> to add a new blog.
        </div>

        <div align="right" style="padding-right: 10px">
            <cfoutput>
                <form name="searchBlogs" id="searchBlogs" method="post" action="/src/pages/listBlogs.cfm?page=#pageNumber#">
                    <input type="text" name="inputData" id="inputData" value="#formSearchValue#"/>
                    <button type="submit" name="search" style="padding: 4px 6px 4px 6px;"/><i class="fa fa-search"></i></button><br>
                    <a style="margin-right: 125px;" align="left" href="/src/pages/listBlogs.cfm?page=#pageNumber#">Reset search</a>
                </cfoutput>
            </form>
        </div>

        <cfif getTotalBlogs.recordCount EQ 0>
            <h4 align="center">We have no new blogs at this moment. Please check back later.</h2>
        </cfif>

        <cfif getTotalBlogs.recordCount GT 0>
            <div width="1200px" align="left" id="blog-list-container">
                <cfset counter = pageSize - 1 />
                        
                <cfloop query="listBlogPages">
                    <cfset blogNumber = pagesize * pageNumber - counter />
                    <cfoutput>
                        <p>
                            <h3 class="date-header">#dateFormat(listBlogPages.blogCreatedDate, "ddd, mmmm dd, yyyy")#</h3><span class="blog-owner"> <i>By #listBlogPages.username#</i><br/></span>
                            <span><a href="/src/pages/displayBlog.cfm?blogId=#blogNumber#" class="blog-title"><cfif formSearchValue EQ ''>#blogNumber#. </cfif>#listBlogPages.blogTitle#</a></span>
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
                        <cfset pages = blogCount / pageSize + 1>
                        <cfset searchpages = searchCount / pageSize + 1 >
                        <cfif searchpages gt 1>
                            <cfset searchTill = searchpages>
                        <cfelse>
                            <cfset searchTill = pages>
                        </cfif>
                        <cfloop from="1" to="#searchTill#" index="i">
                            <li class="page-item"><a class="page-link page-number" href="/src/pages/listBlogs.cfm?page=#i#">#i#</a></li>
                        </cfloop>
                    </cfoutput>
                    <cfoutput>
                        <li class="page-item"><a class="page-link" href=<cfif blogNumber LT #blogCount#>"/src/pages/listBlogs.cfm?page=#pageNumber+1#" </cfif>>Next</a></li>
                    </cfoutput>
                </ul>
            </nav>
        </cfif>
    </cfoutput>
</body>
<script type="text/javascript">
    function clickPage(obj){
        var pageNum = jQuery(obj).text();
        return pageNum;
    }
            
</script>
</html>