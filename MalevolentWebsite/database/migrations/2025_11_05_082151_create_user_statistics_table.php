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
            $table->integer('rank')->default(0);
            $table->integer('prestige')->default(0);
            $table->integer('level')->default(1);
            $table->integer('color')->default("7");
            $table->integer('banned')->default(0);
            $table->bigInteger('money')->default(100000);
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
