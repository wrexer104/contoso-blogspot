<cfcomponent displayname="loginValidation" output="false">

    <cffunction name="getLoginErrors"  access="public" output="false" returntype="string">
        <cfargument name="form" type="struct" required="true">

        <cfset errors = "">
        <cfif len(trim(loginUser)) eq 0>
            <cfset errors = listAppend(errors, "Username is required.")>
        </cfif>
        <cfif len(trim(loginPwd)) eq 0>
            <cfset errors = listAppend(errors, "Password is required.")>
        </cfif>
        
        <cfif len(trim(loginUser)) NEQ 0>
            <cfquery name="validateUsername" datasource="cfBlogspot">
                SELECT * FROM dbo.[User] where username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.loginUser#">
            </cfquery>

            <cfif validateUsername.recordcount eq 0>
                <cfset errors = listAppend(errors, "This username does not exist.")>
            </cfif>
        </cfif>
        
        <cfquery name="getPasswordSalt" datasource="cfBlogspot">
            SELECT passwordhash, salt FROM dbo.[User] where username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.loginPwd#">
        </cfquery>

        <cfif getPasswordSalt.recordcount eq 1>
            <cfif getPasswordSalt.passwordhash NEQ hash(form.loginPwd & getPasswordSalt.salt, "SHA-512")>
                <cfset errors = listAppend(errors, "Password is incorrect.")>
            </cfif>
        </cfif>

        <cfreturn errors>

    </cffunction>

</cfcomponent>