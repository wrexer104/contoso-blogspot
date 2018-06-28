<cfset currDate = now()>

<cfoutput>
    <div align="center">
        <h1 align="center">Welcome to your blog, #session.user#!!</h1>
        <span>Today's date: #dateFormat(currDate, "ddd, mmmm dd, yyyy")#</span>
    </div>

</cfoutput> 