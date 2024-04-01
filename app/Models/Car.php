<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Car extends Model
{
    use HasFactory;

    protected $fillable = [
        'category_id',
        'color',
        'model',
        'make',
        'registration_no'
    ];

    public function category(){
        return $this->belongsTo(Category::class);
    }
}
