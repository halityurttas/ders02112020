<cfquery datasource="testdatasource">
    INSERT INTO Customers (Title, Phone) 
    VALUES (<cfqueryparam cfsqltype="cf_sql_nvarchar" value="#form.title#">, <cfqueryparam cfsqltype='CF_SQL_NVARCHAR' value='#form.phone#'>)
</cfquery>
<script type="text/javascript">
    document.location = '/customer.cfm';
</script>