<cfcomponent displayname="registrationValidation" output="false">

    <cffunction name="getErrorList" access="public" output="false" returntype="string">
        <cfargument name="form" type="struct" required="true">

        <cfset errors = "">

        <cfif len(trim(form.userEmail)) eq 0>
            <cfset errors = listAppend(errors, "Registration email is required.")>
        </cfif>
        <cfif len(trim(form.userName)) eq 0>
            <cfset errors = listAppend(errors, "Registration username is required.")>
        </cfif>
        <cfif len(trim(form.userPwd)) eq 0>
            <cfset errors = listAppend(errors, "Registration password is required.")>
        </cfif>
        <cfif len(trim(form.rptPwd)) eq 0>
            <cfset errors = listAppend(errors, "Repeat the registration password.")>
        </cfif>
        <cfif trim(form.userPwd) neq trim(rptPwd)>
            <cfset errors = listAppend(errors, "Passwords do not match.")>
        </cfif>
        
        <cfreturn errors>
    </cffunction>


    <cffunction name="validateRegistration" access="public" output="false" returntype="boolean">
        <cfargument name="form" type="struct" required="true">
    
        <cfquery name="checkRegisteredEmail">
            select * from dbo.[User] where email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userEmail#">
        </cfquery>

        <!--- User is already registerd --->
        <cfif checkRegisteredEmail.recordcount gt 0>
            <cfreturn 0>
        <cfelse>
            <!--- Generate a password hash, salt and register the user --->
            <cfset variables.salt = hash(generateSecretKey("AES"), "SHA-512")>
            <cfset variables.hashedpassword = hash(form.userPwd & variables.salt, "SHA-512")>

            <cfquery name="registerUser" datasource="cfBlogspot">
                INSERT INTO dbo.[User] (email,username,passwordhash,salt) VALUES (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userEmail#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.userName#">,
                    <cfqueryparam cfsqltype="cf_sql_longnvarchar" value="#variables.hashedpassword#">,
                    <cfqueryparam cfsqltype="cf_sql_longnvarchar" value="#variables.salt#">
                )
            </cfquery>
        </cfif>
            <cfreturn 1>
    </cffunction>


</cfcomponent>