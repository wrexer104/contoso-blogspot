<cfset currDate = now()>

<cfoutput>
    <div align="center">
        <h1 align="center">Welcome to your blog, #session.user#!</h1>
        <span>Today's date: #dateFormat(currDate, "ddd, mmmm dd, yyyy")#</span>
        <a href="/src/pages/home.cfm">Logout</a>
    </div>

</cfoutput> 