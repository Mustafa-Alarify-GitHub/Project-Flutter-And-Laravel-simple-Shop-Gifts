<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Gift extends Model
{

    // use HasFactory;
    protected $guarded =[];

// في نموذج Gift.php
    public function usersWhoFavorited()
    {
        return $this->belongsToMany(User::class, 'favorites', 'gift_id', 'user_id');
    }

}
