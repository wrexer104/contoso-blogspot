<cfset oSearch = createobject("component", "src.components.search") />

<cfif isDefined("search")>
    <cfif len(trim(inputData))>
        <cfset searchqueryResults = oSearch.getSearchResults(form)>
        <cflocation url="/src/pages/listBlogs.cfm">
    </cfif>
</cfif>