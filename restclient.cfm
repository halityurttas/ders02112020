<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <cfhttp method="PUT" url="http://dummy.restapiexample.com/api/v1/update/2" result="updemployees">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
        <cfhttpparam type="body" value='{"employee_name":"Garrett Winters","employee_salary":"120130","employee_age":"63","profile_image":""}'>
    </cfhttp>

    <!--- <cfdump var="#updemployees#"> --->

    <cfif updemployees.statuscode eq "200 OK">
        <cfset updemp = deserializeJSON(updemployees.filecontent)>
        <cfdump var="#updemp#">
    </cfif>

    <cfhttp url="http://dummy.restapiexample.com/api/v1/employees" result="apiemployees">
        <cfhttpparam type="header" name="Content-Type" value="application/json">
    </cfhttp>
    <cfif apiemployees.statuscode eq "200 OK">
        <cfset emps = deserializeJSON(apiemployees.filecontent)>
        <cfdump var="#emps#">

        <!--- <cfloop array="#emps.data#" index="emp">
            <cfquery name="add_emps" datasource="workcube_devcatalyst_2019_1">
                INSERT INTO HY_EMPLOYEES(id, employee_age, employee_name, employee_salary)
                VALUES( #emp.id#, #emp.employee_age#, '#emp.employee_name#', #emp.employee_salary# )
            </cfquery>
        </cfloop> --->
    </cfif>

</body>
</html>