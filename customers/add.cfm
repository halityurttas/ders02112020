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

    <cfoutput>
    <form name="form1" method="POST" action="/customers/insert.cfm">
        <div>�nvan <input type="text" name="title" value=""></div>
        <div>Telefon <input type="text" name="phone" value=""></div>
        <button type="submit">Kaydet</button>
    </form>
    </cfoutput>
</body>
</html>