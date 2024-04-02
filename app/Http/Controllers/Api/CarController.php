<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Car;
use App\Models\Category;
use Illuminate\Http\Request;

class CarController extends Controller
{
    public function index()
    {
        $cars = Car::with('category')->get();
        $categories = Category::get();
        return response([
            'cars' => $cars,
            'categories'=>$categories,
            'status' => true,
        ],200);
    }


    public function store(Request $request)
    {
        $request->validate([
            'category_id' => 'required|exists:categories,id',
            'color' => 'required',
            'model' => 'required',
            'make' => 'required',
            'registration_no' => 'required|unique:cars',
        ]);

        $carDetail = Car::create($request->all());
        return response([
            'car' => $carDetail,
            'status' => true,
        ],200);
    }


    public function update(Request $request, Car $car,$id)
    {
        $request->validate([
            'category_id' => 'required|exists:categories,id',
            'color' => 'required',
            'model' => 'required',
            'make' => 'required',
            'registration_no' => 'required',
        ]);
        $car = Car::findOrFail($id);
        $car->update($request->all());
        return response([
            'car' => $car,
            'status' => true,
        ], 200);


    }

    public function destroy($id)
    {
        $car = Car::findOrFail($id);
        $car->delete();
        return response([
            'status' => true,
        ], 200);
    }



}
