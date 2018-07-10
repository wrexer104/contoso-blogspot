<cfset currDate = now()>

<body>
<style type="text/css">
    div.header {
        padding: 10px;
    }

    div.header 
        span {
            font-size: 16px;
        }
    
</style>

<div class="header" width="inherit" align="center">
    <cfoutput>
        <span align="center">Today's date: <b>#dateFormat(currDate, "ddd, mmmm dd, yyyy")#</b></span><br>
    </cfoutput>
    <a href="/src/pages/home.cfm" style="float: right;"><u>Logout</u></a></td>
</div>
</body>