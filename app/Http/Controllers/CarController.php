<?php

namespace App\Http\Controllers;

use App\Models\Car;
use App\Models\Category;
use Illuminate\Http\Request;
use Inertia\Inertia;

class CarController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $cars = Car::with('category')->get();
        $categories = Category::get();
        return inertia('Car/Index', [
            'cars' => $cars,
            'categories' => $categories
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'category_id' => 'required|exists:categories,id',
            'color' => 'required',
            'model' => 'required',
            'make' => 'required',
            'registration_no' => 'required|unique:cars',
        ]);

        Car::create($request->all());
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Car $car)
    {
        $request->validate([
            'category_id' => 'required|exists:categories,id',
            'color' => 'required',
            'model' => 'required',
            'make' => 'required',
            'registration_no' => 'required|unique:cars,registration_no,' . $car->id,
        ]);

        $car->update($request->all());
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Car $car)
    {
        $car->delete();
        return Inertia::render('Car/Index')->with('success', 'Car deleted successfully.');
    }
}
