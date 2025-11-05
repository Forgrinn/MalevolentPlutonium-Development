////////////////////////////////////////
// Include Base Game Scripts          //
////////////////////////////////////////
#include maps/mp/_utility;            //
#include common_scripts/utility;      //
#include maps/mp/zombies/_zm_utility; //
#include maps/mp/zombies/_zm;         //
////////////////////////////////////////

/////////////////////////////////////////////////
// Include Account Scripts                     //
/////////////////////////////////////////////////
#include scripts/zm/Account/AccountInitialize; //
/////////////////////////////////////////////////

///////////////////////////////////////////////
// Include Chat Command Scripts              //
///////////////////////////////////////////////
#include scripts/zm/Chat/InitializeCommands; //
///////////////////////////////////////////////

main() {
    // Nothing here for now
}

init() {
    level thread initialize_player();
    level thread initialize_commands();
}

initialize_player() {
    for(;;)
    {
        level waittill("connected", player);

        player thread initialize_account();
    }
}