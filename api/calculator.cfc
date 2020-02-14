<cfcomponent restPath="calculator" rest="true">

    <cffunction name="topla" access="remote" consumes="application/json" produces="application/json" restPath="topla" returntype="any" returnformat="JSON" httpMethod="GET">
        <cfargument name="bodydata" type="struct">
        <cfset result = arguments.bodydata.num1 + arguments.bodydata.num2>
        <cfreturn result>
    </cffunction>

    <cffunction name="topla_post" access="remote" produces="application/json" restPath="toplapost" returntype="any" returnformat="JSON" httpMethod="POST">
        <cfargument name="num1" type="numeric" restargsource="FORM">
        <cfargument name="num2" type="numeric" restargsource="FORM">

        <cfset result = arguments.num1 + arguments.num2>
        <cfreturn result>
    </cffunction>

</cfcomponent>