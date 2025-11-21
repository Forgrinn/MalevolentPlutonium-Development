//////////////////////////////////////////////
// Include Base Game Scripts                //
//////////////////////////////////////////////
#include maps/mp/_utility;                  //
#include common_scripts/utility;            //
#include maps/mp/zombies/_zm_utility;       //
#include maps/mp/gametypes_zm/_hud_util;    //
#include maps/mp/gametypes_zm/_hud_message; //
//////////////////////////////////////////////

hud_element_health_initialize(player)
{
    level endon( "end_game" );

    baseX_health_bar = 0;
    baseX_health_bar_text = 85;
    baseX_health_bar_name_text = 0;
    baseX_health_map_name_text = 0;

    baseY_health_bar = 140;
    baseY_health_bar_text = 152;
    baseY_health_bar_name_text = 130;
    baseY_health_map_name_text = 152;

    player.health_bar = player createprimaryprogressbar();
    player.health_bar.width = 100;
    player.health_bar.height = 2;
    player.health_bar.alpha = 0;

    player.health_bar_text = player createFontString("Objective", 1);
    player.health_bar_name_text = player createFontString("Objective", 1);
    player.health_map_name_text = player createFontString("Objective", 1);

    player.health_bar setpoint("LEFT", "LEFT", baseX_health_bar, baseY_health_bar);
    player.health_bar_text setpoint("LEFT", "LEFT", baseX_health_bar_text, baseY_health_bar_text);
    player.health_bar_name_text setpoint("LEFT", "LEFT", baseX_health_bar_name_text, baseY_health_bar_name_text);
    player.health_map_name_text setpoint("LEFT", "LEFT", baseX_health_map_name_text, baseY_health_map_name_text);

    player.health_bar_name_text.label = &"SCORE ";
    player.health_bar_name_text setValue(player.score);
    player.health_map_name_text setText(toUpper("Health"));

    hudElems = array(player.health_bar.bar, player.health_bar, player.health_bar_text, player.health_bar_name_text, player.health_map_name_text);
    for(i = 0; i < hudElems.size; i++)
    {
        hudElems[i].hidewheninmenu = 1;
        hudElems[i].hidewheninscope = 1;
    }

    player.health_bar_text.color = (0.2745, 0.6431, 0.8078);
    player.health_bar.bar.color = (0.2745, 0.6431, 0.8078);

    player thread update_health_hud_parallax(player, baseX_health_bar, baseX_health_bar_text, baseX_health_bar_name_text, baseX_health_map_name_text, baseY_health_bar, baseY_health_bar_text, baseY_health_bar_name_text, baseY_health_map_name_text);
    player thread hud_element_last_zombie_hit();

    while(true)
    {
        if (int(player.score) == 1000000)
            player.health_bar_name_text setValue(999999);
        else
            player.health_bar_name_text setValue(player.score);

        if (isDefined(player.afk_time) && player.afk_time > 0) {
            player.health_bar updatebar(int(player.afk_time) / 300);
            player.health_bar_text setValue(player.afk_time);
        } else {
            if (isDefined(player.last_zombie_hit) && player.last_zombie_hit.health > 0) {
                zombie = player.last_zombie_hit;
                player.health_bar updatebar(zombie.health / zombie.maxhealth);
                player.health_bar_text setValue(zombie.health);
            } else if (isDefined(player.adrenaline_active) && player.adrenaline_active > 0) {
                player.health_bar updatebar(int(player.adrenaline_active) / 5);
                player.health_bar_text setValue(player.adrenaline_active);
            } else {
                player.health_bar updatebar(player.health / player.maxhealth);
                player.health_bar_text setValue(player.health);
            }
        }

        wait 0.01;
    }
}

hud_element_last_zombie_hit()
{
    self endon("disconnect");
    level endon( "end_game" );

    while (true)
    {
        if (isDefined(self.last_zombie_hit))
            wait 2;
            self.last_zombie_hit = undefined;

        wait 2;
    }
}

update_health_hud_parallax(player, baseX_bar, baseX_text, baseX_name, baseX_map, baseY_bar, baseY_text, baseY_name, baseY_map)
{
    player endon("disconnect");
    level endon( "end_game" );

    last_yaw = (player getPlayerAngles())[1];
    last_pitch = (player getPlayerAngles())[0];

    smoothed_offset_x = 0;
    smoothed_offset_y = 0;

    smoothing_factor = 0.1;
    max_offset_x = 20;
    max_offset_y = 25;

    while (true)
    {
        view_angles = player getPlayerAngles();
        current_pitch = view_angles[0];
        current_yaw = view_angles[1];

        yaw_delta = current_yaw - last_yaw;
        if (yaw_delta > 180) yaw_delta -= 360;
        if (yaw_delta < -180) yaw_delta += 360;

        pitch_delta = current_pitch - last_pitch;
        if (pitch_delta > 180) pitch_delta -= 360;
        if (pitch_delta < -180) pitch_delta += 360;

        last_yaw = current_yaw;
        last_pitch = current_pitch;

        normalizedLookX = yaw_delta / 6.0;
        normalizedLookY = pitch_delta / 6.0;

        if (normalizedLookX > 1.0) normalizedLookX = 1.0;
        if (normalizedLookX < -1.0) normalizedLookX = -1.0;
        if (normalizedLookY > 1.0) normalizedLookY = 1.0;
        if (normalizedLookY < -1.0) normalizedLookY = -1.0;

        normalizedLookX = normalizedLookX * abs(normalizedLookX);
        normalizedLookY = normalizedLookY * abs(normalizedLookY);

        target_offset_x = normalizedLookX * max_offset_x;
        target_offset_y = normalizedLookY * -25; // Use literal negative value

        smoothed_offset_x += (target_offset_x - smoothed_offset_x) * smoothing_factor;
        smoothed_offset_y += (target_offset_y - smoothed_offset_y) * smoothing_factor;

        player.health_bar setpoint("LEFT", "LEFT", baseX_bar + smoothed_offset_x, baseY_bar + smoothed_offset_y);
        player.health_bar_text setpoint("LEFT", "LEFT", baseX_text + smoothed_offset_x, baseY_text + smoothed_offset_y);
        player.health_bar_name_text setpoint("LEFT", "LEFT", baseX_name + smoothed_offset_x, baseY_name + smoothed_offset_y);
        player.health_map_name_text setpoint("LEFT", "LEFT", baseX_map + smoothed_offset_x, baseY_map + smoothed_offset_y);

        wait 0.01;
    }
}