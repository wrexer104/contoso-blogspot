<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style type="text/css">
        table#blog-table td {
            font-weight: bold;
        } 
    </style>
</head>

<body>

    <div class="container">
        <cfoutput>        
            <h1 align="center">Welcome to your blog, #session.user#!</h1>
        </cfoutput>
        <cfinclude template="/src/pages/headerinfo.cfm">
        
        <div class="blog-container" align="center">
            <form name="addBlog" id="addBlog" action="/src/pages/listBlogs.cfm" method="post"></form>
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
                </table>
            </form>
        </div>
    </div>
</body>
</html>