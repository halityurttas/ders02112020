<!--- Standart Satinalma Siparis Formu --->
<cfset attributes.order_id = attributes.action_id>
<cfquery name="Our_Company" datasource="#dsn#">
	SELECT 
		ASSET_FILE_NAME3,
		ASSET_FILE_NAME3_SERVER_ID,
		COMPANY_NAME,
		TEL_CODE,
		TEL,TEL2,
		TEL3,
		TEL4,
		FAX,
		TAX_OFFICE,
		TAX_NO,
		ADDRESS,
		WEB,
		EMAIL
	FROM 
	    OUR_COMPANY 
	WHERE 
	<cfif isDefined("SESSION.EP.COMPANY_ID")>
		COMP_ID = #SESSION.EP.COMPANY_ID#
	<cfelseif isDefined("SESSION.PP.COMPANY")>	
		COMP_ID = #SESSION.PP.COMPANY#
	</cfif>
</cfquery>
<cfif isDefined('attributes.ORDER_ID')>
	<cfquery name="Get_Order" datasource="#DSN#">
		SELECT
			E.EMPLOYEE_NAME,
			E.EMPLOYEE_SURNAME,
			E.EMPLOYEE_EMAIL,			
			O.*
		FROM 
			#dsn3_alias#.ORDERS O , 
			EMPLOYEES E
		WHERE 
			O.ORDER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.order_id#"> AND
			E.EMPLOYEE_ID = O.RECORD_EMP
	</cfquery>
</cfif>
<cfquery name="Get_Order_Rows" datasource="#dsn3#">
	SELECT
		ORR.*,
		S.BARCOD,
		S.MANUFACT_CODE,
		S.STOCK_CODE
	FROM
		ORDER_ROW ORR,
		STOCKS S
	WHERE
		ORR.ORDER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.order_id#"> AND
		ORR.STOCK_ID = S.STOCK_ID
	ORDER BY
		ORR.ORDER_ROW_ID
</cfquery>
<cfif len(Get_Order.Deliver_Dept_id)>
    <cfquery name="Get_Store" datasource="#dsn#">
    	SELECT DEPARTMENT_HEAD,BRANCH_ID FROM DEPARTMENT WHERE DEPARTMENT_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Order.Deliver_Dept_id#">
    </cfquery>
</cfif>
<cfif len(Get_Order.Paymethod)>
	<cfset attributes.paymethod_id = Get_Order.Paymethod>
    <cfquery name="Get_Paymethod" datasource="#dsn#">
    	SELECT * FROM SETUP_PAYMETHOD WHERE PAYMETHOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.Paymethod_id#">
    </cfquery>
</cfif>
<!--- Uye bilgileri --->
<cfset Member_Code = "">
<cfset Member_Name = "">
<cfset Member_Mail = "">
<cfset Member_TaxOffice = "">
<cfset Member_TaxNo = "">
<cfset Member_TelCode = "">
<cfset Member_Tel = "">
<cfset Member_Fax = "">
<cfset Member_Address = "">
<cfset Member_Semt = "">
<cfset Member_County = "">
<cfset Member_City = "">
<cfset Member_Country = "">
<cfif isdefined("Get_Order.Company_Id") and Len(Get_Order.Company_Id)>
	<cfquery name="Get_Member_Info" datasource="#dsn#">
		SELECT
            COMPANY_ID MEMBER_ID,
            MEMBER_CODE MEMBER_CODE,
            FULLNAME MEMBER_NAME,
            COMPANY_EMAIL MEMBER_EMAIL,
            TAXOFFICE MEMBER_TAXOFFICE,
            TAXNO MEMBER_TAXNO,
            COMPANY_TELCODE MEMBER_TELCODE,
            COMPANY_TEL1 MEMBER_TEL,
            COMPANY_FAX MEMBER_FAX,
            COMPANY_ADDRESS MEMBER_ADDRESS,
            SEMT MEMBER_SEMT,
            COUNTY MEMBER_COUNTY,
            CITY MEMBER_CITY,
            COUNTRY MEMBER_COUNTRY
        FROM
            COMPANY
        WHERE
            COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Order.Company_Id#">
	</cfquery>
<cfelseif isdefined("Get_Order.Consumer_Id") and Len(Get_Order.Consumer_Id)>
	<cfquery name="Get_Member_Info" datasource="#dsn#">
        SELECT
        	CONSUMER_ID MEMBER_ID,
            MEMBER_CODE MEMBER_CODE,
            CONSUMER_NAME + ' ' + CONSUMER_SURNAME MEMBER_NAME,
            CONSUMER_EMAIL MEMBER_EMAIL,
            TAX_OFFICE MEMBER_TAXOFFICE,
            TAX_NO MEMBER_TAXNO,
            CONSUMER_WORKTELCODE MEMBER_TELCODE,
            CONSUMER_WORKTEL MEMBER_TEL,
            CONSUMER_FAXCODE + '' + CONSUMER_FAX MEMBER_FAX,
            WORKADDRESS MEMBER_ADDRESS,
            WORKSEMT MEMBER_SEMT,
            WORK_COUNTY_ID MEMBER_COUNTY,
            WORK_CITY_ID MEMBER_CITY,
            WORK_COUNTRY_ID MEMBER_COUNTRY
        FROM
        	CONSUMER
        WHERE
        	CONSUMER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Order.Consumer_Id#">
	</cfquery>
</cfif>
<cfif isdefined("Get_Member_Info") and Get_Member_Info.RecordCount>
	<cfset Member_Code = Get_Member_Info.Member_Code>
    <cfset Member_Name = Get_Member_Info.Member_Name>
    <cfset Member_Mail = Get_Member_Info.Member_Email>
    <cfset Member_TaxOffice = Get_Member_Info.Member_TaxOffice>
    <cfset Member_TaxNo = Get_Member_Info.Member_TaxNo>
    <cfset Member_TelCode = Get_Member_Info.Member_TelCode>
    <cfset Member_Tel = Get_Member_Info.Member_Tel>
    <cfset Member_Fax = Get_Member_Info.Member_Fax>
    <cfset Member_Address = Get_Member_Info.Member_Address>
    <cfset Member_Semt = Get_Member_Info.Member_Semt>
    
	<cfif Len(Get_Member_Info.Member_County)>
		<cfquery name="Get_County_Name" datasource="#dsn#">
			SELECT COUNTY_NAME FROM SETUP_COUNTY WHERE COUNTY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Member_Info.Member_County#">
		</cfquery>
		<cfset Member_County = Get_County_Name.County_Name>
	</cfif>
	<cfif Len(Get_Member_Info.Member_City)>
		<cfquery name="Get_City_Name" datasource="#dsn#">
			SELECT CITY_NAME FROM SETUP_CITY WHERE CITY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Member_Info.Member_City#">
		</cfquery>
		<cfset Member_City = Get_City_Name.City_Name>
	</cfif>
	<cfif Len(Get_Member_Info.Member_Country)>
		<cfquery name="Get_Country_Name" datasource="#dsn#">
			SELECT COUNTRY_NAME FROM SETUP_COUNTRY WHERE COUNTRY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Member_Info.Member_Country#">
		</cfquery>
		<cfset Member_Country = Get_Country_Name.Country_Name>
	</cfif>
</cfif>
<cfif Len(Get_Order.Partner_id)>
    <cfquery name="Get_Partner" datasource="#dsn#">
        SELECT COMPANY_PARTNER_NAME + ' ' + COMPANY_PARTNER_SURNAME PARTNER_NAME FROM COMPANY_PARTNER WHERE PARTNER_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Order.Partner_id#">
    </cfquery>
	<cfset Partner_Name = Get_Partner.Partner_Name>
<cfelse>
	<cfset Partner_Name = ''>
</cfif>
<cfif Len(Get_Order.Ship_Method)>
    <cfquery name="Get_Ship_Method" datasource="#dsn#">
        SELECT
            SHIP_METHOD_ID,
            SHIP_METHOD
        FROM
            SHIP_METHOD
        WHERE 
            SHIP_METHOD_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Order.Ship_Method#">
    </cfquery>
</cfif>
<cfquery name="Get_Upper_Position" datasource="#dsn#">
	SELECT * FROM EMPLOYEE_POSITIONS WHERE EMPLOYEE_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.userid#">
</cfquery>
<cfif len (Get_Upper_Position.Upper_Position_Code)>
    <cfquery name="Get_Chief1_Name" datasource="#dsn#">
        SELECT EMPLOYEE_NAME,EMPLOYEE_SURNAME FROM EMPLOYEE_POSITIONS WHERE POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#Get_Upper_Position.Upper_Position_Code#">
    </cfquery>
</cfif>
<cfset Row_Start = 1>
<cfset Row_End = 28>
<cfset yazilan_satir=1>
<cfif Get_Order_Rows.RecordCount>
	<cfset Page_Count = Ceiling((Get_Order_Rows.RecordCount)/Row_End)>
<cfelse>
	<cfset Page_Count = 1>
</cfif>
<cfscript>
	sepet_total = 0;
	sepet_toplam_indirim = 0;
	sepet_total_tax = 0;
	sepet_net_total = 0;
</cfscript>
 <style>
	.box_yazi {border : 0px none #e1ddda;border-width : 0px 0px 0px 0px;border-bottom-width : 0px;background-color : transparent;background-color:#FFFFFF;text-align: left;font:Arial, Helvetica, sans-serif;font-size:12px;} 
	table,td{font-size:11px;font-family:Arial, Helvetica, sans-serif;}
</style>
<cfloop from="1" to="#Page_Count#" index="i">
<table border="0" cellspacing="0" cellpadding="0" style="width:200mm;height:287mm;">
    <tr>
        <td style="width:10mm;" rowspan="40">&nbsp;</td>
        <td style="height:10mm;">&nbsp;</td>
    </tr>
    <tr valign="top">
        <td valign="top">
            <table border="0" cellpadding="0" cellspacing="0" style="width:180mm;">
                <tr height="16">
                    <cfoutput query="our_company">
                        <td align="left" width="60%"><cf_get_server_file output_file="settings/#asset_file_name3#" output_server="#asset_file_name3_server_id#" output_type="5"></td>
                        <td style="text-align:right;">
                            <b>#company_name#</b><br/>
                            #address#<br/>
                            <cf_get_lang_main no='87.Telefon'>: #tel_code# #tel#<br/>
                            <cf_get_lang_main no='76.Fax'>: #tel_code# #fax#<br/>
                            #web#&nbsp;&nbsp;#email#
                        </td>
                    </cfoutput>
                </tr>
                <tr><td colspan="2" style="height:10mm;">&nbsp;</td></tr>
            </table>
            <table cellpadding="3" cellspacing="0" border="1" style="width:180mm;">
			<cfoutput>
                <tr>
                    <td width="35%" bgcolor="000000"><font color="FFFFFF" size="3"><cf_get_lang_main no="2211.SATINALMA SİPARİŞ"></font></td>
                    <td style="text-align:left;width:45mm;"><b><cf_get_lang_main no='468.Belge No'> :</b> #Get_Order.Order_Number#</td>
                    <td style="text-align:right;"><b><cf_get_lang_main no='330.Tarih'> :</b> #dateformat(Get_Order.Order_Date,dateformat_style)#</td>
                </tr>
			</cfoutput>
            </table>
            <table border="0" cellspacing="0" cellpadding="0" style="width:180mm;">
			<cfoutput>
                <tr><td colspan="3" style="height:10mm;">&nbsp;</td></tr>
                <tr style="height:7mm;">
                    <td style="width:20mm;" class="txtbold"><cf_get_lang_main no='1195.Firma'></td>
                    <td style="width:70mm;">:#Member_Name#</td>
                    <td style="width:30mm;" class="txtbold"><cf_get_lang_main no='1384.Sipariş Veren'></td>
                    <td style="width:70mm;">:
                        <cfif len(Get_Order.Order_Employee_id)>
                            #get_emp_info(Get_Order.Order_Employee_id,0,0)#
                        <cfelse>
                            #get_emp_info(Get_Order.Record_Emp,0,0)#
                        </cfif>
                    </td>
                </tr>
                <tr style="height:7mm;">
                    <td class="txtbold"><cf_get_lang_main no='166.Yetkili'></td>
                    <td>:<cfif isdefined("Partner_Name")>#Partner_Name#</cfif></td>
                    <td class="txtbold"><cf_get_lang_main no='233.Teslim Tarihi'></td>
                    <td>:<cfif len(Get_Order.Deliverdate)>#dateformat(Get_Order.Deliverdate,dateformat_style)#</cfif></td>
                </tr>
                <tr style="height:7mm;">
                    <td class="txtbold"><cf_get_lang_main no='87.Telefon'></td>
                    <td>: <cfif len(Member_Tel)>(#Member_TelCode#) #Member_Tel#</cfif></td>
                    <td class="txtbold"><cf_get_lang_main no='1703.Sevk Yöntemi'></td>
                    <td>: <cfif len(Get_Order.ship_method)>#Get_Ship_Method.Ship_Method#</cfif></td>
                </tr>
                <tr style="height:7mm;">
                    <td class="txtbold"><cf_get_lang_main no='1311.Adres'></td>
                    <td style="width:70mm;">:#Get_Order.Ship_Address#</td>
                    <td class="txtbold"><cf_get_lang_main no='1104.Ödeme Yöntemi'></td>
                    <td>: <cfif len(Get_Order.Paymethod)>#Get_Paymethod.Paymethod#</cfif></td>
                </tr>
                <tr style="height:7mm;">
                     <td class="txtbold"><cf_get_lang_main no='217.Açıklama'></td>
                     <td>: <cfif len(Get_Order.Order_Detail)>#Get_Order.Order_Detail#</cfif></td>
                </tr>
			</cfoutput>
            </table>
		</td>
	</tr>
    <tr style="height:6mm;"><td>&nbsp;</td></tr>
    <tr valign="top">
        <td>
            <table border="0" cellspacing="0" cellpadding="0" style="width:180mm;">
                <tr bgcolor="CCCCCC">
                    <td class="bold"><cf_get_lang_main no='1173.KOD'></td>
                    <td class="bold"><cf_get_lang_main no='217.Açıklama'></td>
                    <td class="bold" width="60" style="text-align:right;"><cf_get_lang_main no='223.Miktar'></td>
                    <td class="bold" style="text-align:right;"><cf_get_lang no='1689.Net Fiyat'></td>
                    <td class="bold" style="text-align:right;"><cf_get_lang_main no='80.Toplam'></td>
                </tr>
                <cfoutput query="Get_Order_Rows" startrow="#Row_Start#" maxrows="#Row_End#">
                	<cfif not IsDefined('ilk_urun_id')><cfset ilk_urun_id=Get_Order_Rows.PRODUCT_ID></cfif>
                    <cfscript>
                        if (not len(QUANTITY)) QUANTITY = 1;
                        if (not len(PRICE)) 
                            price = 0;
                        tax_percent = TAX;
                        if (not len(discount_1)) indirim1 = 0; else indirim1 = discount_1;
                        if (not len(discount_2)) indirim2 = 0; else indirim2 = discount_2;
                        if (not len(discount_3)) indirim3 = 0; else indirim3 = discount_3;
                        if (not len(discount_4)) indirim4 = 0; else indirim4 = discount_4;
                        if (not len(discount_5)) indirim5 = 0; else indirim5 = discount_5;
                        indirim6 = 0;
                        indirim7 = 0;
                        indirim8 = 0;
                        indirim9 = 0;
                        indirim10 = 0;
                        indirim_carpan = (100-indirim1) * (100-indirim2) * (100-indirim3) * (100-indirim4) * (100-indirim5);
                    
                        other_money_value = price_other;	
                        other_money_price = OTHER_MONEY_VALUE;
                        net_maliyet = COST_PRICE;
                        marj = MARJ;
                        if(len(price_other))
                            other_money_rowtotal = price_other;
                        else
                            other_money_rowtotal = price;
                        row_total = QUANTITY * price;
                        row_nettotal = wrk_round((row_total/10000000000) * indirim_carpan);
                        row_taxtotal = wrk_round(row_nettotal * (tax_percent/100));
                        row_lasttotal = row_nettotal + row_taxtotal;
                        sepet_total = sepet_total + row_total; //subtotal_
                        sepet_toplam_indirim = sepet_toplam_indirim + wrk_round(row_total) - wrk_round(row_nettotal); //discount_
                        sepet_total_tax = sepet_total_tax + row_taxtotal; //totaltax_
                        sepet_net_total = sepet_net_total + row_lasttotal; //nettotal_
                    </cfscript>
                    <tr>
                        <td style="width:25mm;">#Stock_Code#</td>
                        <td style="width:55mm;">#left(Product_Name,42)#</td>
                        <td style="text-align:right;">#Quantity#&nbsp;#Unit#</td>
                        <td style="width:40mm;text-align:right;"><cfif Quantity neq 0>(#TLFormat(row_nettotal/Quantity)#) #session.ep.money#<cfelse>#TLFormat(row_nettotal)# #session.ep.money#</cfif></td>
                        <td style="width:40mm;text-align:right;">#TLFormat(row_nettotal)# #session.ep.money#</td>
                    </tr>
                </cfoutput>
            </table>
        </td>
    </tr>		
    <tr style="height:6mm;"><td>&nbsp;</td></tr>
    <tr valign="top">
        <td>
            <table border="0" cellpadding="0" cellspacing="0" align="left">
                <cfoutput>
                    <tr style="height:7mm;">
                        <td style="width:15mm;" class="txtbold"><cf_get_lang_main no='10.Notlar'> :</td>
                        <td style="width:128mm;"><input type="text" class="box_yazi" style="width:45mm; font-size:12px;"/></td>
                    </tr>
                </cfoutput>
            </table>
            <table border="0" cellspacing="0" cellpadding="0" style="text-align:right;">
			<cfoutput>
                <tr>
                    <td width="100"><cf_get_lang_main no="153.Ara"> <cf_get_lang_main no="80.Toplam"></td>
                    <td class="txtbold" style="text-align:right;">#TLFormat(sepet_total)# #session.ep.money#</td>
                </tr>
                <tr>
                    <td><cf_get_lang_main no='229.İskonto'></td>
                    <td class="txtbold" style="text-align:right;">#TLFormat(sepet_toplam_indirim)# #session.ep.money#</td>
                </tr>
                <tr>
                    <td><cf_get_lang no="914.Vergi"></td>
                    <td class="txtbold" style="text-align:right;">#TLFormat(sepet_total_tax)# #session.ep.money#</td>
                </tr>
                <tr>
                    <td><cf_get_lang_main no='1737.Toplam Tutar'></td>
                    <td class="txtbold" style="width:20mm;text-align:right;">#TLFormat(sepet_net_total)#  #session.ep.money#</td>
                </tr>
            </cfoutput>
            </table>
        </td>
        <td style="width:10mm;">&nbsp;</td>
    </tr>
    <tr>
        <td>
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <cfoutput>
                <tr><td colspan="3" style="height:5mm;">&nbsp;</td></tr>
                <tr style="height:7mm;">
                    <td class="txtbold"><cf_get_lang no="916.ONAYLAR"></td>
                </tr>
                <tr style="height:7mm;">
                    <td style="width:50mm;" class="txtbold"><cf_get_lang_main no='1714.YÖNETİCİ'><cf_get_lang_main no='88.ONAY'></td>
                    <td style="width:50mm;" class="txtbold"><cf_get_lang_main no='1714.YÖNETİCİ'><cf_get_lang_main no='88.ONAY'></td>
                </tr>
                <tr style="height:7mm;">
                    <td><cfif Len(Get_Upper_Position.Upper_Position_Code)>
                            #Get_Chief1_Name.EMPLOYEE_NAME# #Get_Chief1_Name.EMPLOYEE_SURNAME#
                        </cfif>
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </cfoutput>
            </table>
        </td>
    </tr>
	<tr height="100%"><td>&nbsp;</td></tr>
</table>
<cfset Row_Start = Row_End + Row_Start>
</cfloop>
