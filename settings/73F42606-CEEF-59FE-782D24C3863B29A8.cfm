<cfif isDefined("caller.attributes.assetp_id")>
    <cfquery name="query_ders01_upd" datasource="#caller.dsn#">
        IF EXISTS( SELECT 1 FROM HY_DERS01 WHERE Action_ID = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#caller.attributes.assetp_id#'> )
        BEGIN
            UPDATE HY_DERS01 SET Emp_Phone = <cfqueryparam cfsqltype='CF_SQL_NVARCHAR' value='#caller.attributes.emp_phone#'> WHERE Action_ID = <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#caller.attributes.assetp_id#'>
        END
        ELSE
        BEGIN
            INSERT INTO HY_DERS01(Emp_Phone, Action_ID)
            VALUES(
                <cfqueryparam cfsqltype='CF_SQL_NVARCHAR' value='#caller.attributes.emp_phone#'>,
                <cfqueryparam cfsqltype='CF_SQL_INTEGER' value='#caller.attributes.assetp_id#'>
            )
        END;
    </cfquery>
</cfif>