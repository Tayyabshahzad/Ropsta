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
            <button class="btn btn-info" @click="showCarWrapper()"> Create Car </button>

            <br/>  <br/>
            <div class="row">
              <table class="table table-border">
                <tr>
                  <th> Category  </th> <th> Color </th> <th> Model </th>  <th> Make </th> <th> Registration No </th> <th> Action </th>
                </tr>
                <tr v-for="car in cars" :key="car.id">
                  <td>{{ car.category.name }}</td>
                  <td>{{ car.color }}</td>
                  <td>{{ car.model }}</td>
                  <td>{{ car.make }}</td>
                  <td>{{ car.registration_no }}</td>
                  <td>
                    <button @click="editCar(car)">Edit</button> |
                    <button @click="deleteCar(car.id)">Delete</button>
                  </td>
                </tr>
              </table>
            </div>
          </div>

          <form @submit.prevent="handleSubmit" class="row">
            <div class="mb-4 col-lg-6">
              <label for="category" class="block text-sm font-medium text-gray-700 dark:text-gray-300">Category </label>
              <select v-model="categoryName" id="category" name="category" class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                <option value="">Select a category</option>
                <option v-for="category in categories" :key="category.id" :value="category.id">{{ category.name }}</option>
              </select>
              <span v-if="errors.has('categoryName')" class="text-red-500">{{ errors.first('categoryName') }}</span>
            </div>

            <!-- Other form fields -->

            <div class="mb-4 col-lg-6">
              <br>
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
  import { useForm, usePage } from '@inertiajs/inertia-vue3';
  import { Head } from '@inertiajs/vue3';
  import { ref } from 'vue';
  import useVuelidate from "@vuelidate/core";
  import {email,required } from "@vuelidate/validators";

  export default {
    components: {
      AuthenticatedLayout,
      Head
    },

    validations() {
        return {
            title: {
                required: helpers.withMessage('Please select a title.', required),
            },
            firstName: {
                required: helpers.withMessage('Please enter your first name.', required),
            },
            lastName: {
                required: helpers.withMessage('Please enter your last name.', required),
            },
            phoneNumber: {
                required: helpers.withMessage('Please enter your phone number.', required),
                remoteValidation: helpers.withMessage('Please enter a valid UK landline or mobile phone number, which starts with ‘0’ instead of ‘+44’.', helpers.withAsync(remoteValidation)),
                $autoDirty: true,
            },
            email: {
                required: helpers.withMessage('Please enter your email address.', required),
                email: helpers.withMessage('Please enter a valid email address. E.g. example@emailaddress.com', email),
            },
            privacyAgreed: {
                sameAs: helpers.withMessage('Please read and accept the privacy policy to continue.', sameAs(true)),
            },
        };
    },
    methods: {
        scrollToTopOfForm() {
            setTimeout(() => {
                const formWrapper = document.querySelector('#claim-form');
                formWrapper.scrollIntoView(true);
            }, 20);
        },
        async submit() {
            this.pending = true;
            await this.$recaptchaLoaded();
            const recaptchaToken = await this.$recaptcha('form');
            const isValid = await this.v$.$validate();
            if (!isValid) {
                this.validationError = true;
                this.pending = false;
                this.scrollToTopOfForm();
                if (this.v$.phoneNumber.$dirty && !this.v$.$pending && this.v$.phoneNumber.remoteValidation.$invalid) {
                    logInvalidTelephone(this.name, this.phoneNumber, this.email);
                }
            } else {
                this.validationError = false;
                this.scrollToTopOfForm();
                axios.post(`${this.action}`, {
                    title: this.title,
                    firstName: this.firstName,
                    lastName: this.lastName,
                    phoneNumber: this.phoneNumber,
                    email: this.email,
                    type: Fraud.APP,
                    privacyAgreed: this.privacyAgreed,
                    utm_medium: this.utm_medium,
                    utm_source: this.utm_source !== '' ? this.utm_source : this.source,
                    utm_content: this.utm_content,
                    utm_term: this.utm_term,
                    utm_campaign: this.utm_campaign,
                    gclid: this.gclid,
                    msclkid: this.msclkid,
                    recaptchaToken,
                }).then(() => {
                    window.location.href = this.redirectUrl;
                }).catch(error => {
                    console.error(error);
                    this.pending = false;
                    if (typeof error.response.data.message !== "undefined") {
                        this.formError = error.response.data.message;
                        if (error.response.data.errors) {
                            this.serverValidationErrors = error.response.data.errors;
                        }
                    }
                    this.scrollToTopOfForm();
                    if (typeof dataLayer !== "undefined") {
                        dataLayer.push({
                            'event': 'virtualPageView',
                            'pageUrl': '/scams-app/error',
                            'pageTitle': 'Error'
                        });
                    }
                });
            }
        }
    },

    props: {
      cars: {
        type: Object,
        default: () => ({})
      },
      categories: {
        type: Object,
        default: () => ({})
      }
    },

  };
  </script>
