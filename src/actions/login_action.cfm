<cfset oLogin = createobject("component", "src.components.login") />

<cfif isDefined("btnLogin")>
    <cfset loginErrList = oLogin.getLoginErrors(form)>
    
    <cfif listLen(loginErrList) eq 0>
        <cfset session.user = "#form.loginUser#">
        <cfset loginSuccess = 1>
        <cflocation url="/src/pages/AddBlog.cfm">
    </cfif>
</cfif>