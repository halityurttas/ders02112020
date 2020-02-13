<cfcomponent>

    <cffunction name="customer_list">
        <cfargument name="title" default="">
        <cfargument name="phone" default="">

        <cfquery name="query_customer" datasource="testdatasource" result="result_customer">
            Select * From customers

            WHERE 1=1
            
            <cfif len(arguments.title)>
            AND title LIKE '%#arguments.title#%'
            </cfif>
            <cfif len(arguments.phone)>
            AND phone LIKE '%#arguments.phone#%'
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

    <cffunction name="insert">
        <cfargument name="title">
        <cfargument name="phone">

        <cfquery datasource="testdatasource">
            INSERT INTO Customers (Title, Phone) 
            VALUES (
            <cfqueryparam cfsqltype="cf_sql_nvarchar" value="#arguments.title#">
            ,<cfqueryparam cfsqltype='CF_SQL_NVARCHAR' value='#arguments.phone#'>
            )
        </cfquery>
    </cffunction>

</cfcomponent>