//////////////////////////////////////////////
// Include Base Game Scripts                //
//////////////////////////////////////////////
#include maps/mp/_utility;                  //
#include common_scripts/utility;            //
#include maps/mp/zombies/_zm_utility;       //
#include maps/mp/gametypes_zm/_hud_util;    //
#include maps/mp/gametypes_zm/_hud_message; //
#include maps/mp/zombies/_zm_weapons;       //
//////////////////////////////////////////////

///////////////////////////////////////
// Include Utility Scripts           //
///////////////////////////////////////
#include scripts/zm/Utility/Utility; //
///////////////////////////////////////

hud_element_ammo_initialize(player)
{
    player endon("disconnect");
    level endon( "end_game" );

    baseX_ammo_bar = 0;
    baseX_ammo_bar_text = 0;
    baseX_ammo_bar_name_text = -65;
    baseX_ammo_map_name_text = -79;

    baseY_ammo_bar = 140;
    baseY_ammo_bar_text = 152;
    baseY_ammo_bar_name_text = 130;
    baseY_ammo_map_name_text = 152;

    player.ammo_bar = player createprimaryprogressbar();
    player.ammo_bar.width = 100;
    player.ammo_bar.height = 2;
    player.ammo_bar.alpha = 0;

    player.ammo_bar_text = player createFontString("Objective", 1);
    player.ammo_bar_name_text = player createFontString("Objective", 1);
    player.ammo_map_name_text = player createFontString("Objective", 1);

    player.ammo_bar setpoint("RIGHT", "RIGHT", baseX_ammo_bar, baseY_ammo_bar);
    player.ammo_bar_text setpoint("RIGHT", "RIGHT", baseX_ammo_bar_text, baseY_ammo_bar_text);
    player.ammo_bar_name_text setpoint("RIGHT", "RIGHT", baseX_ammo_bar_name_text, baseY_ammo_bar_name_text);
    player.ammo_map_name_text setpoint("RIGHT", "RIGHT", baseX_ammo_map_name_text, baseY_ammo_map_name_text);

    player.ammo_bar_name_text.label = &"ZOMBIES ";
    player.ammo_map_name_text setText(toUpper("Ammo"));

    hudElems = array(player.ammo_bar.bar, player.ammo_bar, player.ammo_bar_text, player.ammo_bar_name_text, player.ammo_map_name_text);
    for(i = 0; i < hudElems.size; i++)
    {
        hudElems[i].hidewheninmenu = 1;
        hudElems[i].hidewheninscope = 1;
    }

    player thread update_ammo_hud_parallax(player, baseX_ammo_bar, baseX_ammo_bar_text, baseX_ammo_bar_name_text, baseX_ammo_map_name_text, baseY_ammo_bar, baseY_ammo_bar_text, baseY_ammo_bar_name_text, baseY_ammo_map_name_text);

    while(true)
    {
        player.ammo_bar_name_text setvalue(get_current_zombie_count());

        player.ammo_bar_text.color = (0.2745, 0.6431, 0.8078);
        player.ammo_bar.bar.color = (0.2745, 0.6431, 0.8078);

        currentWeapon = player getcurrentweapon();

        player.ammo_bar updatebar(player getweaponammostock(currentWeapon) / utility_weapon_stock_size(currentWeapon));
        player.ammo_bar_text setValue(player getweaponammoclip(currentWeapon));

        if(is_true(level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) && !isdefined(self.powerup_hud["fire_sale"]))
            self powerup_hud_create("fire_sale", "specialty_firesale_zombies", 0);
        else if(!is_true(level.zombie_vars["zombie_powerup_fire_sale_on"] == 1) && isdefined(self.powerup_hud["fire_sale"]))
            self powerup_hud_destroy("fire_sale");

        if(is_true(level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1) && !isdefined(self.powerup_hud["insta_kill"]))
            self powerup_hud_create("insta_kill", "specialty_instakill_zombies", 1);
        else if(!is_true(level.zombie_vars[self.team]["zombie_powerup_insta_kill_on"] == 1) && isdefined(self.powerup_hud["insta_kill"]))
            self powerup_hud_destroy("insta_kill");

        if(is_true(level.zombie_vars[self.team]["zombie_powerup_point_doubler_on"] == 1) && !isdefined(self.powerup_hud["double_points"]))
            self powerup_hud_create("double_points", "specialty_doublepoints_zombies", 1);
        else if(!is_true(level.zombie_vars[self.team]["zombie_powerup_point_doubler_on"] == 1) && isdefined(self.powerup_hud["double_points"]))
            self powerup_hud_destroy("double_points");

        wait 0.01;
    }
}

update_ammo_hud_parallax(player, baseX_bar, baseX_text, baseX_name, baseX_map, baseY_bar, baseY_text, baseY_name, baseY_map)
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
        target_offset_y = normalizedLookY * (0 - max_offset_y);

        smoothed_offset_x += (target_offset_x - smoothed_offset_x) * smoothing_factor;
        smoothed_offset_y += (target_offset_y - smoothed_offset_y) * smoothing_factor;

        player.ammo_bar setpoint("RIGHT", "RIGHT", baseX_bar + smoothed_offset_x, baseY_bar + smoothed_offset_y);
        player.ammo_bar_text setpoint("RIGHT", "RIGHT", baseX_text + smoothed_offset_x, baseY_text + smoothed_offset_y);
        player.ammo_bar_name_text setpoint("RIGHT", "RIGHT", baseX_name + smoothed_offset_x, baseY_name + smoothed_offset_y);
        player.ammo_map_name_text setpoint("RIGHT", "RIGHT", baseX_map + smoothed_offset_x, baseY_map + smoothed_offset_y);

        wait 0.01;
    }
}

powerup_hud_create(powerup, shader, team)
{
	if(!isdefined(self.powerup_hud))
	{
		self.powerup_hud = [];
	}
	if(isdefined(self.powerup_hud[powerup]))
	{
		return;
	}
	hud = self createicon(shader, 32, 32);
	hud setpoint("CENTER", "BOTTOM", 0, -48);
	hud.foreground = 1;
	hud.sort = 1;
	hud.hidewheninmenu = 1;
	hud.hidewheninscope = 1;
	hud.alpha = 1;
	hud thread powerup_hud_fade(powerup, self, team);
	self.powerup_hud[powerup] = hud;
	self powerup_hud_update();
}
powerup_hud_destroy(powerup)
{
	if(!isdefined(self.powerup_hud))
	{
		return;
	}
	if(!isdefined(self.powerup_hud[powerup]))
	{
		return;
	}
	self.powerup_hud[powerup] destroy_hud();
	self.powerup_hud[powerup] = undefined;
	self powerup_hud_update();
}
powerup_hud_update()
{
	if(self.powerup_hud.size <= 0)
	{
		return;
	}
	i = 0;
	foreach(element in self.powerup_hud)
	{
		element.x = i * 18;
		for(k = i + 1; k < self.powerup_hud.size; k++)
		{
			element.x = element.x - 18;
		}
		i++;
	}
}
powerup_hud_fade(powerup, player, team)
{
	self endon("death");
	if(is_true(level.zombie_powerups[powerup].solo))
	{
		user = player;
	}
	else
	{
		user = level;
	}
	if(is_true(team))
	{
		while(is_true(user.zombie_vars[player.team][level.zombie_powerups[powerup].on_name]))
		{
			if(is_true(user.zombie_vars[player.team][level.zombie_powerups[powerup].time_name] < 5))
			{
				wait(0.1);
				self.alpha = 0;
				wait(0.1);
			}
			else if(is_true(user.zombie_vars[player.team][level.zombie_powerups[powerup].time_name] < 10))
			{
				wait(0.2);
				self.alpha = 0;
				wait(0.18);
			}
			self.alpha = 1;
			wait(0.05);

			break;
		}
	}
	while(is_true(user.zombie_vars[level.zombie_powerups[powerup].on_name]))
	{
		if(is_true(user.zombie_vars[level.zombie_powerups[powerup].time_name] < 5))
		{
			wait(0.1);
			self.alpha = 0;
			wait(0.1);
		}
		else if(is_true(user.zombie_vars[level.zombie_powerups[powerup].time_name] < 10))
		{
			wait(0.2);
			self.alpha = 0;
			wait(0.18);
		}
		self.alpha = 1;
		wait(0.05);
	}
}