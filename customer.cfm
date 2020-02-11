<cfparam name="url.title" default="">
<cffunction name="linkyap">
    <cfargument name="id">

    <cfset link = "/customers/edit.cfm?id=#arguments.id#">
    <cfreturn link>
</cffunction>

<cffunction name="bgcolor">
    <cfargument name="unvan">

    <cfif arguments.unvan contains "müdür">
        <cfreturn "red">
    <cfelse>
        <cfreturn "green">
    </cfif>
</cffunction>

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
    <cfinclude template="header.cfm">

    <cfobject type="component" component="customerdata" name="cdata">
    <cfset sonuc = cdata.customer_list(url.title)>

<form name="form1" method="POST" action="/customers/insert.cfm">
    <div>�nvan <input type="text" name="title" value=""></div>
    <div>Telefon <input type="text" name="phone" value=""></div>
    <button type="submit">Kaydet</button>
</form>
<br>
<br>
<br>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>�nvan</th>
                <th>Telefon</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="sonuc">
            <tr>
                <td><a href="#linkyap(CustomerID)#">#CustomerID#</a></td>
                <td style="background-color: #bgcolor(Title)#">#Title#</td>
                <td>#Phone#</td>
            </tr>
            </cfoutput>
        </tbody>
    </table>
</body>
</html>