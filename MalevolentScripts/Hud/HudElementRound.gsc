//////////////////////////////////////////////
// Include Base Game Scripts                //
//////////////////////////////////////////////
#include maps/mp/_utility;                  //
#include common_scripts/utility;            //
#include maps/mp/zombies/_zm_utility;       //
#include maps/mp/gametypes_zm/_hud_util;    //
#include maps/mp/gametypes_zm/_hud_message; //
//////////////////////////////////////////////

hud_element_round_initialize(player)
{
	player endon("disconnect");
	level endon( "end_game" );

	baseX_round = 0;
	baseY_round = 25;

	player.roundCounter = createserverfontstring("default", 25);
    player.roundCounter SetValue(level.round_number);

	player.roundCounter SetPoint("TOP_LEFT", "TOP_LEFT", baseX_round, baseY_round);
	player.roundCounter.alpha = 0;
	player.roundCounter.color = (0, 0, 0);
	player.roundCounter FadeOverTime(1);
	player.roundCounter.color = (0.2745, 0.6431, 0.8078);
	player.roundCounter.alpha = 1;
	player.roundCounter.hidewheninmenu = 1;
	player.roundCounter.hidewheninscope = 1;

	player thread round_hud_parallax(baseX_round, baseY_round);

	while(1)
	{
		level waittill("end_of_round");

		player.roundCounter.color = (0,0,0);
		player.roundCounter FadeOverTime(0.5);
		player.roundCounter.alpha = 0;
		wait 1;

		player.roundCounter SetValue(level.round_number);
		player.roundCounter FadeOverTime(0.7);
		player.roundCounter.color = (0.2745, 0.6431, 0.8078);
		player.roundCounter.alpha = 1;
		player.roundCounter.hidewheninmenu = 1;
	}

	level waittill("between_round_over");
}

round_hud_parallax(baseX, baseY)
{
    player = self;
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
        angles = player getPlayerAngles();
        yaw = angles[1];
        pitch = angles[0];

        yawDelta = last_yaw - yaw;
        if (yawDelta > 180) yawDelta -= 360;
        if (yawDelta < -180) yawDelta += 360;

        pitchDelta = pitch - last_pitch;
        if (pitchDelta > 180) pitchDelta -= 360;
        if (pitchDelta < -180) pitchDelta += 360;

        last_yaw = yaw;
        last_pitch = pitch;

        normalizedYaw = yawDelta / 6.0;
        normalizedPitch = pitchDelta / 6.0;

        if (normalizedYaw > 1.0) normalizedYaw = 1.0;
        if (normalizedYaw < -1.0) normalizedYaw = -1.0;
        if (normalizedPitch > 1.0) normalizedPitch = 1.0;
        if (normalizedPitch < -1.0) normalizedPitch = -1.0;

        normalizedYaw = normalizedYaw * abs(normalizedYaw);
        normalizedPitch = normalizedPitch * abs(normalizedPitch);

        target_offset_x = normalizedYaw * (0 - max_offset_x);
        target_offset_y = normalizedPitch * (0 - max_offset_y);

        smoothed_offset_x += (target_offset_x - smoothed_offset_x) * smoothing_factor;
        smoothed_offset_y += (target_offset_y - smoothed_offset_y) * smoothing_factor;

        player.roundCounter SetPoint("TOP_LEFT", "TOP_LEFT", baseX + smoothed_offset_x, baseY + smoothed_offset_y);

        wait 0.01;
    }
}