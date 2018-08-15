<cfcomponent displayname="search" output="false">

    <cffunction name="getSearchResults" access="public" output="false" returntype="query">
        <cfargument name="form" type="struct" required="true">
        
        <cfquery name="getSearchResults">
            SELECT username, blogTitle, blogContent, blogCreatedDate FROM dbo.Blog INNER JOIN dbo.[User] 
            ON dbo.[User].id = dbo.Blog.userId WHERE blogTitle like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.inputData#%">
            or blogContent like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.inputData#%">
            or username like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.inputData#%">
        </cfquery>

        <cfreturn local.getSearchResults>
    </cffunction>

</cfcomponent>