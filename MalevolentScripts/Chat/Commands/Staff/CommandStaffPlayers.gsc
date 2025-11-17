command_staff_players(args) 
{
    player_data = strToK(self.pers["player_data"], ";");

    if (int(player_data[1]) < 6) {
        self tell("[^5Staff^7] You need to be a staff member to use this command");
        return;
    }

    players = getPlayers();

    foreach(player in players)
        self tell("[^5Players^7] ");
}