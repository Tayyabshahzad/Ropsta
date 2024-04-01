<template>
    <div>
      <AuthenticatedLayout>
        <template #header>
          <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">Categories</h2>
        </template>

        <div class="form-group" style="width: 50%; padding: 50px;">
          <!-- Display success message if available -->
          <div v-if="$page.props.success" class="alert alert-success" role="alert">
            {{ $page.props.success }}  <a :href="route('categories.index')"> Reload Page ...</a>
          </div>

          <!-- Display all categories -->
          <div class="container">
            <div class="row">
                <table class="table table-border">
                    <tr>
                        <th> S# </th> <th> Name </th> <th> Action </th>
                    </tr>
                    <tr v-for="category in categories" :key="category.id">
                        <td> {{ category.id }} </td>  <td> {{ category.name }} </td> <td> <button @click="editCategory(category)">Edit</button> |
                            <button @click="deleteCategory(category.id)">Delete</button>
                        </td>
                     </tr>
                </table>
            </div>
          </div>

          <!-- Edit category form -->
          <div v-if="editingCategory" class="form-group">
            <h3>Edit Category</h3>
            <form @submit.prevent="updateCategory">
              <label for="editedCategoryName">Name:</label>
              <input type="text" class="form-control" v-model="editedCategoryName" id="editedCategoryName" name="editedCategoryName">
              <br/>
              <span v-if="!editedCategoryName" class="text-red-500">Category name is required.</span>
              <br/>
              <button type="submit"  class="btn btn-sm btn-warning">Update</button> &nbsp;&nbsp;
              <button type="button"  class="btn btn-sm btn-info" @click="cancelEditCategory()">Cancel</button>
            </form>
          </div>

          <form @submit.prevent="handleSubmit" v-if="!editingCategory">
            <div class="mb-4">
              <label for="name" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Category Name</label>
              <input type="text"
                     v-model="name"
                     id="name"
                     name="name"
                     class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">

                     <span v-if="nameError" class="text-red-500">Category name is required.</span>
              <br/>
              <button type="submit" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                Save
              </button>
            </div>
          </form>
        </div>
      </AuthenticatedLayout>
    </div>
  </template>

  <script>
  import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue';
  import { Head } from '@inertiajs/vue3';
  import { usePage } from '@inertiajs/inertia-vue3';

  export default {
    components: {
      AuthenticatedLayout,
      Head
    },
    props: {
        categories: {
        type: Array,
        default: () => []
        }
    },
    data() {
      return {
        name: '',
        editingCategory: null,
        editedCategoryName: '',
        nameError:false
      };
    },
    methods: {
      handleSubmit() {
        if (!this.name.trim()) {
            this.nameError = true;
            return false;
        }
        this.nameError = false;

      this.$inertia.post(route('categories.store', { name: this.name })).then(() => {
        this.name = ''; // Clear the input field after successful submission
      }).catch(error => {
        console.error('Error creating category:', error);
      });


      },
      editCategory(category) {
        this.editingCategory = category;
        this.editedCategoryName = category.name;
      },

      cancelEditCategory(category) {
        this.editingCategory = false;
      },
      updateCategory() {
        this.$inertia.put(route('categories.update', { category: this.editingCategory.id }), { name: this.editedCategoryName });
        this.editingCategory = null;
        this.editedCategoryName = '';
     },
     deleteCategory(categoryId) {
        this.$inertia.delete(route('categories.destroy', { category: categoryId })).then(() => {
            this.$inertia.visit(route('categories.index'), { preserveState: true });
        }).catch(error => {
            console.error('Error deleting category:', error);
        });
    }


    }
  };
  </script>
