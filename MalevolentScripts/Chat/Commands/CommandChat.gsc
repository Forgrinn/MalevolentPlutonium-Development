command_chat(args)
{
    // player_data = strToK(self.pers["player-data"], ";");

    string = "";
    iteration = 0;
    foreach (message in args)
    {
        if (iteration > 0)
            if (string == "")
                string = " " + message;
            else
                string = string + " " + message;

        iteration += 1;
    }

    say("[^1OWNER^7][^1L100^7][^1P10^7] ^1 " + self.name + " ^7>" + string);
}