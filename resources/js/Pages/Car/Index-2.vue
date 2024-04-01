<script setup>
import DataTable from 'datatables.net-vue3';

defineProps({
    cars: Object,
})
</script>

<template>
    <DataTable   class="display">
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
</template>

<style>

@import 'datatables.net-dt';
</style>
