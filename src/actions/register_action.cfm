<cfset oRegistration = createobject("component", "src.components.registration") />

<cfif isDefined("btnRegister")>
    <cfset regErrList = oRegistration.getErrorList(form)>
    
    <cfif listLen(regErrList) eq 0>
        <cfset userRegistered = oRegistration.validateRegistration(form)>
        
        <cfif userRegistered eq 0>
            <cfset existingUser = 1>
        </cfif>
        <cflocation url = "/src/pages/home.cfm?existingUser=#existingUser#" />
    </cfif>
</cfif>