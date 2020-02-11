<cfobject type="component" component="customerdata" name="custdata">
<cfset result = custdata.customer_update(form.title, form.phone, form.id)>
<cfif result.durum>
<script type="text/javascript">
    document.location = '/customer.cfm';
</script>
<cfelse>
    <cfdump var="#result.hata.detail#">
</cfif>