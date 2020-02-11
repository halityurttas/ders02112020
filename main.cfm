<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <cfset isimarr = ["hait","deniz","mahmut"]>
<cfloop array="#isimarr#" index="i" item="k">
    <cfoutput>#i#-#k#</cfoutput><br>
</cfloop>
<cf_mytag adi="ahmet">
</body>
</html>