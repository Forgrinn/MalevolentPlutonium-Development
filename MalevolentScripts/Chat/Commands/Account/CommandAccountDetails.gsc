///////////////////////////////////////
// Include Utility Scripts           //
///////////////////////////////////////
#include scripts/zm/Utility/Utility; //
///////////////////////////////////////

////////////////////////////////////////////
// Command Account Details Script         //
////////////////////////////////////////////
// Shows the player their account details //
////////////////////////////////////////////
command_account_details(args)
{
    account = database_query("SELECT * FROM user_statistics WHERE id=?", array(self.guid));

    details = array(
        "",
        "",
        "",
        "",
        ""
    );

    foreach(message in details)
        self tell(message);
}