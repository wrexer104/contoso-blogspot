<cfparam name="blogSaved" default = 0>
<cfset blogPostingErrors = "">
<cfset oBlog = createobject("component", "src.components.postBlog") />

<cfif isDefined("postBlog")>
    <cfset blogPostingErrors = oBlog.getBlogPostingErrorList(form)>

    <cfif listLen(blogPostingErrors) eq 0>
        <cfset blogSaved = oBlog.saveBlogPost(form)>
    </cfif>
</cfif>


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

    <div class="container">
        <cfoutput>
            <h1 align="center">Welcome to your blog, #session.user#!</h1>
        </cfoutput>
        <cfinclude template="/src/pages/headerinfo.cfm">

        <div class="posting-notifications">
            <cfif blogSaved eq 1>
                <span>Blog saved successfully!</span>
            <cfelse>
                <cfif listLen(blogPostingErrors) neq 0>
                    <ul>
                        <cfloop list="#blogPostingErrors#" index="error">
                            <cfoutput>
                                <li class="error">#error#</li>
                            </cfoutput>
                        </cfloop>
                    </ul>
                </cfif>
            </cfif>
        </div>
        
        <div class="blog-container" align="center">
            <form name="addBlog" id="addBlog" action="/src/pages/addBlog.cfm" method="post">
                <table id="blog-table">
                    <tr>
                        <td style="padding: 5px;">Blog title: </td>
                        <td style="padding: 5px;"><input type="text" name="blogTitle" id="blogTitle" size="50"></td>
                    </tr>
                    <tr>
                        <td style="padding: 5px;">Blog content: </td>
                        <td style="padding: 5px;"><textarea name="blogContent" id="blogContent" rows="20" cols="100"></textarea></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding: 5px;"><input type="submit" name="postBlog" id="postBlog" value="Post blog"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <div class="view-more-blogs">
                                <i>Click <a href="/src/pages/listBlogs.cfm?page=1">here</a> to view more blogs by other members.</i>
                            </div>
                        </td>
                    </tr>
                </table>
            </form>
        </div>

        <cfinclude template="/src/pages/footerinfo.cfm">
    </div>
</body>
</html>