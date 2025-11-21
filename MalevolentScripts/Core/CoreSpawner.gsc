////////////////////////////////////////
// Include Base Game Scripts          //
////////////////////////////////////////
#include maps/mp/_utility;            //
#include common_scripts/utility;      //
#include maps/mp/zombies/_zm_utility; //
////////////////////////////////////////

core_last_zombie_hit( mod, hitloc, hitorig, player, damage )
{
    if( player != self && isplayer( player ) && IsDefined( player ) )
    {
        player.last_zombie_hit = self;
    }
    return 0;
}