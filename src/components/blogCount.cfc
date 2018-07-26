<cfcomponent displayname="loginValidation" output="false">

    <cffunction name="getTotalBlogCount" access="public" output="false" returntype="numeric">

        <cfset count = 0 />

        <cfquery name="getTotalBlogs">
            select * from dbo.[Blog] ORDER BY blogCreatedDate;
        </cfquery>

        <cfset count = getTotalBlogs.recordcount />

        <cfreturn count />
    </cffunction>
</cfcomponent>