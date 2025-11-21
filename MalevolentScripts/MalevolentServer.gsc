////////////////////////////////////////
// Include Base Game Scripts          //
////////////////////////////////////////
#include maps/mp/_utility;            //
#include common_scripts/utility;      //
#include maps/mp/zombies/_zm_utility; //
#include maps/mp/zombies/_zm;         //
#include maps/mp/zombies/_zm_perks;   //
////////////////////////////////////////

/////////////////////////////////////////////////
// Include Account Scripts                     //
/////////////////////////////////////////////////
#include scripts/zm/Account/InitializeAccount; //
/////////////////////////////////////////////////

///////////////////////////////////////////////
// Include Chat Command Scripts              //
///////////////////////////////////////////////
#include scripts/zm/Chat/InitializeCommands; //
///////////////////////////////////////////////

////////////////////////////////////////
// Include Core Scripts               //
////////////////////////////////////////
#include scripts/zm/Core/CorePerks;   //
#include scripts/zm/Core/CoreSpawner; //
////////////////////////////////////////

////////////////////////////////////////////
// Include Hud Scripts                    //
////////////////////////////////////////////
#include scripts/zm/Hud/HudElementAmmo;   //
#include scripts/zm/Hud/HudElementHealth; //
#include scripts/zm/Hud/HudElementRound;  //
////////////////////////////////////////////

///////////////////////////////////////////////
// Include Utility Scripts                   //
///////////////////////////////////////////////
#include scripts/zm/Utility/UtilityDatabase; //
#include scripts/zm/Utility/Utility;         //
///////////////////////////////////////////////

main() {
	replacefunc(::give_perk, ::give_perk_cwz);
}

init() {
    setDvar("g_password", "");
    setDvar("password", "");

    level.perk_purchase_limit = 20;

    level thread initialize_player();
    level thread initialize_commands();
    level thread initialize_database();
}

initialize_player() {
    for(;;)
    {
        level waittill("connected", player);
        player thread initialize_account();
        player thread initialize_player_spawn(player);

        player maps\mp\zombies\_zm_spawner::register_zombie_damage_callback(::core_last_zombie_hit);
    }
}

initialize_player_spawn(player) {
    self endon("disconnect");
    level waittill("initial_blackscreen_passed");
    self setClientUIVisibilityFlag("hud_visible", 0);

    self.perk_hud_array = [];

    player thread hud_element_health_initialize(player);
    player thread hud_element_ammo_initialize(player);
    player thread hud_element_round_initialize(player);
}