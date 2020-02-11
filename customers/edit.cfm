<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <cfscript>
        birincimesaj = "bir";
    </cfscript>
    <cfinclude template="../header.cfm">

    <cfquery name="query_customer" datasource="testdatasource" result="result_customer">
        Select CustomerID, Title, Phone From customers WHERE CustomerID = <cfqueryparam cfsqltype="cf_sql_integer" value="#url.id#">
    </cfquery>
    <cfoutput>
    <form name="form1" method="POST" action="update.cfm">
        <input type="hidden" name="id" value="#query_customer.CustomerID#">
        <div>Ünvan <input type="text" name="title" value="#query_customer.Title#"></div>
        <div>Telefon <input type="text" name="phone" value="#query_customer.Phone#"></div>
        <button type="submit">Kaydet</button>
    </form>
    </cfoutput>
</body>
</html>