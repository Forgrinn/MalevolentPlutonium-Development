<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UserStatistics extends Model
{
    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'id',
        'name',
        'player_rank',
        'player_prestige',
        'player_level',
        'player_color',
        'player_banned',
        'player_money',
        'player_code',

        'player_joins',
        'player_quits',
        'player_kills',
        'player_downs',
        'player_revives',
        'player_headshots',
        'player_distance',
        'player_dog_kills',

        'player_boss_kills',
        'player_missions_completed',
        'player_chat_games_won',
        'player_gambled',
        'player_gambled_lost',
        'player_gambled_won',
    ];
}
