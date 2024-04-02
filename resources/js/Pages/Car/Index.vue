<template>
    <div>
      <AuthenticatedLayout>
        <template #header>
          <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">Cars</h2>
        </template>

        <div class="form-group" style="width: 50%; padding: 50px;">
          <!-- Display success message if available -->
          <div v-if="$page.props.success" class="alert alert-success" role="alert">
            {{ $page.props.success }}  <a :href="route('car.index')"> Reload Page ...</a>
          </div>

          <!-- Display all categories -->
          <div class="container">
            <button class="btn btn-info" @click="showCarWrapper('add','')"> Create Car </button>

            <br/>  <br/>

            <div v-if="successMessage" class="alert alert-success" role="alert">
                {{ successMessage }}  <a :href="route('car.index')"> Reload Page ...</a>
              </div>
              <br/>  <br/>




            <div class="row">

              <DataTable class="display col-lg-12 table table-border">
                <thead>
                        <tr>   <th> Category  </th> <th> Color </th> <th> Model </th>  <th> Make </th> <th> Registration No </th> <th> Action </th> </tr>
                </thead>

                <tbody>
                    <tr v-for="car in cars" :key="car.id">
                    <td>{{ car.category.name }}</td>
                    <td>{{ car.color }}</td>
                    <td>{{ car.model }}</td>
                    <td>{{ car.make }}</td>
                    <td>{{ car.registration_no }}</td>
                    <td>
                        <button @click="showCarWrapper('edit',car)">Edit</button> |
                        <button @click="deleteCar(car.id)">Delete</button>
                    </td>
                    </tr>
                </tbody>

              </DataTable>
            </div>
          </div>

          <form @submit.prevent="submit" class="row" v-if="showCarForm">
            <div class="mb-4 col-lg-6">
                <input type="hidden" v-model="car_id">
              <label for="category" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Category </label>
                <select
                    id="category_id"
                    name="category_id"
                    class="form-control"
                    v-model="category_id"
                    :class="{ 'is-invalid': v$.category_id.$error }"
                >
                    <option value=""></option>
                    <option v-for="category in categories" :key="category.id" :value="category.id">{{ category.name }}</option>
                </select>
                <small class="invalid-feedback" v-for="error in v$.category_id.$errors">{{ error.$message }}</small>

            </div>

            <div class=" col-lg-6">
                <label for="color" class="block text-sm font-medium text-gray-700 dark:text-gray-300">color </label>
                <input
                    id="color"
                    name="color"
                    class="form-control"
                    v-model="color"
                    placeholder="color"
                    type="text"
                    :class="{ 'is-invalid': v$.color.$error }"
                >
                <small class="invalid-feedback" v-for="error in v$.color.$errors">{{ error.$message }}</small>
            </div>


            <div class=" col-lg-6">
                <label for="model" class="block text-sm font-medium text-gray-700 dark:text-gray-300">model </label>
                <input
                    id="model"
                    name="model"
                    class="form-control"
                    v-model="model"
                    placeholder="model"
                    type="text"
                    :class="{ 'is-invalid': v$.model.$error }"
                >
                <small class="invalid-feedback" v-for="error in v$.model.$errors">{{ error.$message }}</small>
            </div>



            <div class=" col-lg-6">
                <label for="make" class="block text-sm font-medium text-gray-700 dark:text-gray-300">make </label>
                <input
                    id="make"
                    name="make"
                    class="form-control"
                    v-model="make"
                    placeholder="make"
                    type="text"
                    :class="{ 'is-invalid': v$.make.$error }"
                >
                <small class="invalid-feedback" v-for="error in v$.make.$errors">{{ error.$message }}</small>
            </div>
            <br><br><br>

            <div class=" col-lg-6">
                <label for="registration_no" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Registration No </label>
                <input
                    id="registration_no"
                    name="registration_no"
                    class="form-control"
                    v-model="registration_no"
                    placeholder="registration_no"
                    type="text"
                    :class="{ 'is-invalid': v$.registration_no.$error }"
                >
                <small class="invalid-feedback" v-for="error in v$.registration_no.$errors">{{ error.$message }}</small>
            </div>


            <div class="mb-4 col-lg-6">
              <br>
              <button type="submit" class=" btn btn-info">
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
import { useForm, usePage } from '@inertiajs/inertia-vue3';
import { Head } from '@inertiajs/vue3';
import { ref } from 'vue';
import useVuelidate from "@vuelidate/core";
import {required, helpers } from "@vuelidate/validators";
import axios from "axios";
import DataTable from 'datatables.net-vue3';
async function remoteValidation(value) {
    if (value === '') {
        return true;
    }

    return await validateTelephone(value);
}

export default {

    components: {
      AuthenticatedLayout,
      Head,
      DataTable

    },
    name: "CarDetail",
    props: {
        cars: Object,
        categories: Object,
    },
    setup() {
        return {
            v$: useVuelidate(),
            successMessage: null
        };
    },
    data: () => ({
        validationError: false,
        serverValidationErrors: false,
        car_id : '',
        category_id: '',
        color:'',
        model:'',
        make: '',
        registration_no:'',
        showCarForm : false,
        editCarForm : false,
        editingCar: null,
        updatedCars : {

        }

    }),
    computed: {
    },
    validations() {
        return {
            category_id: {
                required: helpers.withMessage('Please select a title.', required),
            },
            color: {
                required: helpers.withMessage('Please select a color.', required),
            },
            model: {
                required: helpers.withMessage('Please select a model.', required),
            },
            make: {
                required: helpers.withMessage('Please select a make.', required),
            },
            registration_no: {
                required: helpers.withMessage('Please enter   registration no.', required),
            },
        };
    },
    methods: {

        async submit() {
            const isValid = await this.v$.$validate();
            if (!isValid) {
                this.validationError = true;

            } else {
                this.validationError = false;
                if(this.car_id){
                    console.log('edit')
                    axios.put(route('car.update',{ car: this.car_id }), {
                        category_id: this.category_id,
                        color: this.color,
                        model: this.model,
                        make: this.make,
                        registration_no: this.registration_no,
                    }).then((response) => {
                        console.log(response)
                        this.showCarForm = false
                        this.successMessage = "Car Updated";
                        window.location.reload()
                    }).catch(error => {
                        if (error.response && error.response.data && error.response.data.message) {
                            this.errorMessage = error.response.data.message;
                        } else {
                            this.errorMessage = "An error occurred while processing your request.";
                        }
                    });


                }else{
                    axios.post(route('car.store'), {
                        category_id: this.category_id,
                        color: this.color,
                        model: this.model,
                        make: this.make,
                        registration_no: this.registration_no,
                    }).then((response) => {
                        console.log(response)
                        this.showCarForm = false
                        this.successMessage = "Car Added";
                        window.location.reload()
                    }).catch(error => {
                        if (error.response && error.response.data && error.response.data.message) {
                            this.errorMessage = error.response.data.message;
                        } else {
                            this.errorMessage = "An error occurred while processing your request.";
                        }
                    });
                }
            }
        },
        showCarWrapper(type,source){
            if(type == 'edit'){
                this.car_id =  source.id,
                this.category_id = source.category_id,
                this.color =  source.color,
                this.model =  source.model,
                this.make = source.make,
                this.registration_no =  source.registration_no
            }
            this.showCarForm = true
        },
        deleteCar(carId) {
            axios.delete(route('car.destroy',{ car: carId })).then((response) => {
                window.location.reload()
             })
            .catch(error => { });

        },
        showEditCarWrapper(car) {
            this.editingCar = car;
            this.editCarForm = true;
        },
        updateCar(){

        }

    },
    mounted() {

    },
}
</script>
<style>

@import 'datatables.net-dt';
</style>

