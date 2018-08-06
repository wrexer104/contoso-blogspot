<cfcomponent displayname="loginValidation" output="false">

    <cffunction name="getTotalBlogCount" access="public" output="false" returntype="numeric">

        <cfset count = 0 />

        <cfquery name="getTotalBlogs">
            select count(*) as blogCount from dbo.[Blog];
        </cfquery>

        <cfset count = getTotalBlogs.blogCount />

        <cfreturn count />
    </cffunction>
</cfcomponent>