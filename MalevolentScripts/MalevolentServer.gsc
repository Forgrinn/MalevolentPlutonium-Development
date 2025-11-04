////////////////////////////////////////
// Include Base Game Scripts          //
////////////////////////////////////////
#include maps/mp/_utility;            //
#include common_scripts/utility;      //
#include maps/mp/zombies/_zm_utility; //
#include maps/mp/zombies/_zm;         //
////////////////////////////////////////

/////////////////////////////////////////
// Include Chat Command Scripts        //
/////////////////////////////////////////
#include scripts/zm/Chat/InitCommands; //
/////////////////////////////////////////

main() {
    // Nothing here for now
}

init() {
    level thread init_player();
    level thread init_commands();
}

init_player() {
    for(;;)
    {
        level waittill("connected", player);

        // Nothing here for now
    }
}