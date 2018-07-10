<cfcomponent displayname="persistBlog" output="false">

    <cffunction name="getBlogPostingErrorList" access="public" output="false" returntype="string">
        <cfargument name="form" type="struct" required="true">
        <cfset postingErrors = "">

        <cfif len(trim(form.blogTitle)) eq 0>
            <cfset postingErrors = listAppend(postingErrors, "Blog title is required.")>
        </cfif>
        <cfif len(trim(form.blogContent)) eq 0>
            <cfset postingErrors = listAppend(postingErrors, "Blog content cannot be blank.")>
        </cfif>
        
        <cfdump var="#postingErrors#">
        <cfreturn postingErrors>
    </cffunction>


    <cffunction name="saveBlogPost" access="public" output="false" returntype="boolean">
        <cfargument name="form" type="struct" required="true">

        <cfset loggedInUser = #session.user#>

        <cfquery name="getUserId">
            SELECT id FROM dbo.[User] WHERE username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.user#">
        </cfquery>

        <cfquery name="persistBlogToStorage" datasource="cfBlogspot">
            INSERT INTO dbo.[Blog] (userId, blogTitle, blogContent) VALUES (
                <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId.id#">,
                <cfqueryparam cfsqltype="cf_sql_longnvarchar" value="#form.blogTitle#">,
                <cfqueryparam cfsqltype="cf_sql_longnvarchar" value="#form.blogContent#">
            )

        </cfquery>

        <cfreturn 1>

    </cffunction>

</cfcomponent>