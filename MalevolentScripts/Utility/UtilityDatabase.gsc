/////////////////////////////////////
// Initialize Database Function    //
/////////////////////////////////////
// Sets up the database connection //
/////////////////////////////////////
database_initialize()
{
    config          = spawnstruct();
    config.host     = GetDvar("mysql_host");
    config.user     = GetDvar("mysql_user");
    config.password = GetDvar("mysql_pass");
    config.port     = int(GetDvar("mysql_port"));
    config.database = GetDvar("mysql_db");

    mysql::set_config(config);
}

/////////////////////////////////////
// Database Query Function         //
/////////////////////////////////////
// Sends a query to the database   //
/////////////////////////////////////
database_query(stmt, params)
{
    query = mysql::prepared_statement(stmt, params);
    query waittill("done", result, affected_rows, error);

    return array(
        result,
        affected_rows,
        error
    );
}