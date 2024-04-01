<?php

use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\CarController;
use App\Http\Controllers\Api\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


Route::post('login', [UserController::class, 'login'])->name('api.login');
Route::post('register', [UserController::class, 'register'])->name('api.register');



Route::middleware('auth:api')->group(function () {
    // Get user details
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Category routes
    Route::get('categories', [CategoryController::class, 'index'])->name('api.categories');
    Route::post('categories', [CategoryController::class, 'store'])->name('api.categories.post');
    Route::get('categories/{id}', [CategoryController::class, 'show'])->name('api.categories.show');
    Route::put('categories/{id}', [CategoryController::class, 'update'])->name('api.categories.update');
    Route::delete('categories/{id}', [CategoryController::class, 'destroy'])->name('api.categories.delete');

    // Car routes
    Route::get('cars', [CarController::class, 'index']);
    Route::post('cars', [CarController::class, 'store']);
    Route::get('cars/{id}', [CarController::class, 'show']);
    Route::put('cars/{id}', [CarController::class, 'update']);
    Route::delete('cars/{id}', [CarController::class, 'destroy']);
});



