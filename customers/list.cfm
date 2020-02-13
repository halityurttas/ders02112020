<cfparam name="form.title" default="">
<cfparam name="form.phone" default="">
<cfparam name="form.page" default="1">

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

    <form action="list.cfm" method="POST">
        <cfoutput>
        <table>
            <tr>
                <td>Ünvan</td>
                <td><input type="text" name="title" value="#form.title#"></td>
            </tr>
            <tr>
                <td>Telefon</td>
                <td><input type="text" name="phone" value="#form.phone#"></td>
            </tr>
            <tr>
                <td colspan="2">
                    <button type="submit">Ara</button>
                </td>
            </tr>
            <tr>
                <td>Sayfa</td>
                <td>
                    <input type="text" name="page" value="#form.page#">
                </td>
            </tr>
        </table>
        </cfoutput>
    </form>
    <cfobject name="cdata" type="component" component="customerdata">
    <cfset qcustomers = cdata.customer_list(form.title, form.phone)>
    
    <table border="1">
        <thead>
            <tr>
                <td>Ünvan</td>
                <td>Telefon</td>
                <td><a href="/customers/add.cfm">Ekle</a></td>
            </tr>
        </thead>
        <tbody>
            <cfset pageStart = ((form.page-1)*3)+1>
            <cfoutput query="qcustomers" maxrows="3" startrow="#pageStart#">
            <tr>
                <td>#Title#</td>
                <td>#Phone#</td>
                <td><a href="/customers/edit.cfm?id=#CustomerID#">Düzenle</a></td>
            </tr>
            </cfoutput>
        </tbody>
    </table>
</body>
</html>