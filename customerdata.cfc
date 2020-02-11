<cfcomponent>

    <cffunction name="customer_list">
        <cfargument name="title" default="">

        <cfquery name="query_customer" datasource="testdatasource" result="result_customer">
            Select * From customers
            <cfif len(arguments.title)>
            WHERE title LIKE '%#arguments.title#%'
            </cfif>
        </cfquery>

        <cfreturn query_customer>
    </cffunction>

    <cffunction name="customer_update">
        <cfargument name="title">
        <cfargument name="phone">
        <cfargument name="id">

        <cftry>
        <cfquery datasource="testdatasource">
            UPDATE Customers SET Title = <cfqueryparam cfsqltype="cf_sql_nvarchar" value="#arguments.title#">, Phone = <cfqueryparam cfsqltype='CF_SQL_NVARCHAR' value='#arguments.phone#'>
            WHERE CustomerID = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#arguments.id#'>
        </cfquery>
        <cfreturn { durum: 1 }>
        <cfcatch>
        <cfreturn {durum: 0, hata: cfcatch}>
        </cfcatch>
        </cftry>
    </cffunction>

</cfcomponent>