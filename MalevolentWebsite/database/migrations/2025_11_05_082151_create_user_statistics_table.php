<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user_statistics', function (Blueprint $table) {
            $table->foreignId('id')->primary();
            $table->string('name')->unique();
            $table->integer('player_rank')->default(0);
            $table->integer('player_prestige')->default(0);
            $table->integer('player_level')->default(1);
            $table->integer('player_color')->default("7");
            $table->integer('player_banned')->default(0);
            $table->bigInteger('player_money')->default(100000);
            $table->integer('player_code')->nullable();

            $table->integer('player_joins')->default(0);
            $table->integer('player_quits')->default(0);
            $table->integer('player_kills')->default(0);
            $table->integer('player_downs')->default(0);
            $table->integer('player_revives')->default(0);
            $table->integer('player_headshots')->default(0);
            $table->integer('player_distance')->default(0);
            $table->integer('player_dog_kills')->default(0);

            $table->integer('player_boss_kills')->default(0);
            $table->integer('player_missions_completed')->default(0);
            $table->integer('player_chat_games_won')->default(0);
            $table->integer('player_gambled')->default(0);
            $table->integer('player_gambled_lost')->default(0);
            $table->integer('player_gambled_won')->default(0);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_statistics');
    }
};
