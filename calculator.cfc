<cfcomponent hint="Calculating Service">

    <cffunction name="add" access="remote" returntype="string" hint="add two number">
        <cfargument name="num1" type="numeric">
        <cfargument name="num2" type="numeric">

        <cfset result = num1 + num2>

        <cfreturn result>
    </cffunction>

    <cffunction name="stok_durum" access="remote" returntype="query" hint="stok durum maliyet hesaplama raporu" output="true">
        <cfargument name="location_id" type="string" default="">
        <cfargument name="aylar" type="string" default="">
        <cfargument name="product_id" type="string" default="">
<!---
        <cftry>
--->
        <cfquery name="query_stock" datasource="workcube_devcatalyst_2019_1">
            SELECT STK.STOCK_ID, STK.STOCK_CODE, AVG(INR.GROSSTOTAL) AS AVGTOTAL,
            
            (SELECT PRODUCT_NAME FROM workcube_devcatalyst_product.PRODUCT WHERE PRODUCT_ID = STK.PRODUCT_ID) AS PNAME
    
            FROM workcube_devcatalyst_product.STOCKS STK
            INNER JOIN INVOICE_ROW INR ON STK.STOCK_ID = INR.STOCK_ID
    
            <cfif len(arguments.location_id) or len(arguments.aylar)>
            INNER JOIN INVOICE INV ON INV.INVOICE_ID = INR.INVOICE_ID
            </cfif>
            
            WHERE INR.PURCHASE_SALES = 1
            <cfif len(arguments.product_id)>
                AND INR.PRODUCT_ID = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#arguments.product_id#'>
            </cfif>
            <cfif len(arguments.location_id)>
                AND INV.DEPARTMENT_LOCATION = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#arguments.location_id#'>
            </cfif>
            <cfif len(arguments.aylar)>
                AND DATEPART(MONTH, INV.INVOICE_DATE) = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#arguments.aylar#'>
            </cfif>
            GROUP BY STK.STOCK_ID, STK.STOCK_CODE, STK.PRODUCT_ID
        </cfquery>
<!---
        <cfcatch>
            <cfsavecontent variable="result">
            <cfdump var="#cfcatch#">
            </cfsavecontent>
        </cfcatch>

        </cftry>
--->
        <cfreturn query_stock>
    </cffunction>

    <cffunction name="operations" access="remote" returntype="struct">
        <cfargument name="num1" type="numeric">
        <cfargument name="num2" type="numeric">

        <cfset result = {
            sum: num1+num2,
            diff: num1-num2
        }>

        <cfreturn result>
    </cffunction>

</cfcomponent>