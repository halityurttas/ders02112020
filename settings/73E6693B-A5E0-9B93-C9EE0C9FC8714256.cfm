<cfset emp_phone = "">
<script type="text/javascript">
    $(document).ready(function() {
        <cfif isDefined("caller.attributes.assetp_id")>
            <cfquery name="query_ders01" datasource="#caller.dsn#">
                SELECT * FROM HY_DERS01 WHERE Action_ID = <cfqueryparam cfsqltype='CF_SQL_INTEGEr' value='#caller.attributes.assetp_id#'>
            </cfquery>
            <cfif query_ders01.recordCount>
                <cfset emp_phone = query_ders01.Emp_phone>
            </cfif>
        </cfif>
        var htmlcode = `<div class="form-group" id="item-director-phone">
                    <label class="col col-4 col-xs-12 control-label"> Yönetici Telefon</label>
                    <div class="col col-8 col-xs-12">
                      <input type="text" name="emp_phone" id="emp_phone" value="<cfoutput>#emp_phone#</cfoutput>">
                    </div>
                  </div>`;
        $("#item-form_ul_special_code").after(htmlcode);
    });
  </script>