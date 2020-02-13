<cfparam name="attributes.isfiltered" default="0">
<cfparam name="attributes.product_id" default="">
<cfparam name="attributes.product_name" default="">
<cfparam name="attributes.department_id" default="">
<cfparam name="attributes.location_id" default="">
<cfparam name="attributes.location_name" default="">
<cfparam name="attributes.aylar" default="">

<cfform action="#request.self#?fuseaction=#attributes.fuseaction#&report_id=#attributes.report_id#" method="post" name="filter_form">
    <input type="hidden" name="isfiltered" value="1">
    <cf_report_list_search title="Filtre">
        <cf_report_list_search_area>
            <div class="row">
                <div class="col col-12 col-xs-12">
                    <div class="row formContent">
                        <div class="row" type="row">
                            <div class="col col-4 col-md-4 col-sm-6 col-xs-12">
                
                                <div class="form-group">
                                    <label class="col col-4 col-xs-12"><cf_get_lang dictionary_id="57657"></label>
                                    <div class="col col-8 col-xs-12">
                                    <div class="input-group">

                                        <input type="hidden" name="product_id" id="product_id" <cfif len(attributes.product_id) and len(attributes.product_name)>value="<cfoutput>#attributes.product_id#</cfoutput>"</cfif>>

                                        <input name="product_name" type="text" id="product_name" placeholder="<cf_get_lang dictionary_id="57657">" onfocus="AutoComplete_Create('product_name','PRODUCT_NAME','PRODUCT_NAME','get_product','0','PRODUCT_ID','product_id','','3','100');" value="<cfif len(attributes.product_id) and len(attributes.product_name)><cfoutput>#attributes.product_name#</cfoutput></cfif>" autocomplete="off">

                                        <span class="input-group-addon btnPointer icon-ellipsis" onclick="windowopen('<cfoutput>#request.self#</cfoutput>?fuseaction=objects.popup_product_names&product_id=filter_form.product_id&field_name=filter_form.product_name&keyword='+encodeURIComponent(document.filter_form.product_name.value),'list');"></span>

                                    </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col col-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label class="col col-4 col-xs-12">Lokasyon</label>
                                    <div class="col col-8 col-xs-12">
                                    <cf_wrkdepartmentlocation 
                                        returninputvalue="location_id,location_name,department_id"
                                        returnqueryvalue="LOCATION_ID,LOCATION_NAME,DEPARTMENT_ID"
                                        fieldname="location_name"
                                        fieldid="location_id"
                                        status="0"
                                        is_department="1"
                                        department_fldid="department_id"
                                        department_id="#attributes.department_id#"
                                        location_id="#attributes.location_id#"
                                        location_name="#attributes.location_name#"
                                        user_level_control="#session.ep.OUR_COMPANY_INFO.IS_LOCATION_FOLLOW#"
                                        user_location = "0"
                                        width="140">
                                    </div>
                                </div>
                            </div>
                            <div class="col col-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <label class="col col-4 col-xs-12">Ay</label>
                                    <div class="col col-8 col-xs-12">
                                <select name="aylar">
                                    <option value="" <cfif attributes.aylar eq "">selected</cfif>>Seciniz</option>
                                    <option value="1" <cfif attributes.aylar eq "1">selected</cfif>>ocak</option>
                                    <option value="2" <cfif attributes.aylar eq "2">selected</cfif>>Şubat</option>
                                    <option value="3" <cfif attributes.aylar eq "3">selected</cfif>>Mart</option>
                                    <option value="4" <cfif attributes.aylar eq "4">selected</cfif>>Nisan</option>
                                    <option value="5" <cfif attributes.aylar eq "5">selected</cfif>>Mayıs</option>
                                    <option value="6" <cfif attributes.aylar eq "6">selected</cfif>>Hazir</option>
                                    <option value="7" <cfif attributes.aylar eq "7">selected</cfif>>Temmuz</option>
                                    <option value="8" <cfif attributes.aylar eq "8">selected</cfif>>Ağst</option>
                                    <option value="9" <cfif attributes.aylar eq "9">selected</cfif>>Eyl</option>
                                    <option value="10" <cfif attributes.aylar eq "10">selected</cfif>>Ekm</option>
                                    <option value="11" <cfif attributes.aylar eq "11">selected</cfif>>Kas</option>
                                    <option value="12" <cfif attributes.aylar eq "12">selected</cfif>>Araık</option>
                                </select>
                                </div>
                            </div>
                            <div class="col col-4 col-md-4 col-sm-6 col-xs-12">
                                <div class="form-group">
                                    <cf_wrk_report_search_button search_function='input_control()'>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </cf_report_list_search_area>
    </cf_report_list_search>
</cfform>

<cfif attributes.isfiltered eq 1>

    <cfquery name="query_stock" datasource="#dsn2#">
        SELECT STK.STOCK_ID, STK.STOCK_CODE, AVG(INR.GROSSTOTAL) AS AVGTOTAL,
        
        (SELECT PRODUCT_NAME FROM #dsn1#.PRODUCT WHERE PRODUCT_ID = STK.PRODUCT_ID) AS PNAME

        FROM #dsn1#.STOCKS STK
        INNER JOIN INVOICE_ROW INR ON STK.STOCK_ID = INR.STOCK_ID

        <cfif len(attributes.location_id) or len(attributes.aylar)>
        INNER JOIN INVOICE INV ON INV.INVOICE_ID = INR.INVOICE_ID
        </cfif>
        
        WHERE INR.PURCHASE_SALES = 1
        <cfif len(attributes.product_id)>
            AND INR.PRODUCT_ID = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#attributes.product_id#'>
        </cfif>
        <cfif len(attributes.location_id)>
            AND INV.DEPARTMENT_LOCATION = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#attributes.location_id#'>
        </cfif>
        <cfif len(attributes.aylar)>
            AND DATEPART(MONTH, INV.INVOICE_DATE) = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#attributes.aylar#'>
        </cfif>
        GROUP BY STK.STOCK_ID, STK.STOCK_CODE, STK.PRODUCT_ID
    </cfquery>

</cfif>

<cf_report_list>
    <thead>
        <tr>
            <th>Stok ID</th>
            <th>Ürün Adı</th>
            <th>Stok Kodu</th>
            <th>Ortalama Maliyet</th>
        </tr>
    </thead>
    <tbody>
    <cfif attributes.isfiltered eq 1>
        <cfoutput query="query_stock">
        <tr>
            <td>#STOCK_ID#</td>
            <td>#PNAME#</td>
            <td>#STOCK_CODE#</td>
            <td style="text-align: right;">#tlformat(AVGTOTAL, 2)#</td>
        </tr>
        </cfoutput>
    <cfelse>
        <tr><td colspan="3">Lütfen Filtreleyin</td></tr>
    </cfif>
    </tbody>
</cf_report_list>

<script type="text/javascript">
    function input_control() {
        return true;
    }
</script>