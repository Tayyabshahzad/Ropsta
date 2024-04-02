<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{

    public function index()
    {

        $categories = Category::all();
        return Inertia::render('Categories/Index', [
            'categories' => $categories
        ]);
       // return view('categories.index', compact('categories'));
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
            'name' => 'required|unique:categories|max:255',
        ]);
        Category::create($request->all());
        return Inertia::render('Categories/Index')->with('success', 'Category created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $category = Category::where('id',$id);
        return Inertia::render('Categories/Index', [
            'category' => $category
        ]);
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
    public function update(Request $request, Category $category)
    {

        $request->validate([
            'name' => 'required|unique:categories|max:255',
        ]);
        $category->update($request->all());
        // Fetch all categories after updating
        $categories = Category::all();
        // Return updated categories and success message
        return Inertia::render('Categories/Index')->with([
            'categories' => $categories,
            'success' => 'Category updated successfully.'
        ]);
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Category $category)
    {
        $category->delete();
        return Inertia::render('Categories/Index')->with('success', 'Category deleted successfully.');
    }
}
