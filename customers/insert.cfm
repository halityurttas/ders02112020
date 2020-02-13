<cfobject name="custdata" type="component" component="customerdata">
<cfset custdata.insert( form.title, form.phone )>
<script type="text/javascript">
    document.location = '/customers/list.cfm';
</script>