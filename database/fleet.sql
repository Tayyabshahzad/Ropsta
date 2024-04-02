-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 02, 2024 at 11:15 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fleet`
--

-- --------------------------------------------------------

--
-- Table structure for table `cars`
--

CREATE TABLE `cars` (
  `id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `make` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `registration_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cars`
--

INSERT INTO `cars` (`id`, `category_id`, `color`, `model`, `make`, `registration_no`, `created_at`, `updated_at`) VALUES
(13, 27, 'White', '2023', 'Toyota', '112233', '2024-04-02 17:14:54', '2024-04-02 17:15:14');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(27, 'SUV', '2024-04-02 17:13:13', '2024-04-02 17:13:13'),
(28, 'Car Cat', '2024-04-02 17:13:25', '2024-04-02 17:13:44'),
(29, 'Dell Laptop', '2024-04-02 17:22:50', '2024-04-02 17:24:20');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_03_31_215302_create_categories_table', 1),
(6, '2024_03_31_215311_create_cars_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Lamar Gay', 'dozadixave@mailinator.com', NULL, '$2y$12$2nB7JU1AywKp.uZ8sQcaV.tyIaY4Ev7dPgqfUzlYWF9WsPFj8TeA6', NULL, '2024-04-01 16:00:56', '2024-04-01 16:00:56'),
(2, 'Aqsa', 'aqsa@duanni.coom', NULL, '$2y$12$a49qh76tmecKAVCQJqtPqOxhztPc9YlEU8akeXqJmSIZ5xjOliJfe', NULL, '2024-04-01 16:27:23', '2024-04-01 16:27:23'),
(3, 'Aqsa', 'aqsaaa@gmail.com', NULL, '$2y$12$WQFQuFnCh/pCfIS4Fso2lurgyvHIolIQpLQPE54a0ORnNLE0dk/aG', NULL, '2024-04-01 16:29:31', '2024-04-01 16:29:31'),
(4, 'ssss', 'sss@gmail.com', NULL, '$2y$12$gpgjzoJyT5jDxD1KItHzp.E9h7aMWluerN6psftxdjFDdM1.bEOEO', NULL, '2024-04-01 16:29:51', '2024-04-01 16:29:51'),
(5, 'qqwqw', 'qwqwq@gmail.com', NULL, '$2y$12$8xLUOLXV.CEXJTN6obuQCuyiX.OFN6dkzs5Wqy5GcaAg7S5OF/MCa', NULL, '2024-04-01 16:30:21', '2024-04-01 16:30:21'),
(6, '222', '222@gmail.com', NULL, '$2y$12$ZQ3J3qnsWouaURjhzzt4AeSetASNMPnMDSn6E/I3Imzu1TFrg1bA2', NULL, '2024-04-01 16:31:17', '2024-04-01 16:31:17'),
(7, '34', '222@hotmail.com', NULL, '$2y$12$a4xMzCqojgP.HwbNt8l5ResEPYhY6N4zZZbO8QWsijv4hRYQPczta', NULL, '2024-04-01 16:35:36', '2024-04-01 16:35:36'),
(8, 'sssq', 'ami@gmail.com', NULL, '$2y$12$ByE5XxvjRTtwhmPHii/4kujErrZ2lEhmDiqAxCxrLdE1zgx66xE4u', NULL, '2024-04-01 16:38:06', '2024-04-01 16:38:06'),
(9, 'kabeer', 'kabeer@hotmail.com', NULL, '$2y$12$V/yQY0sgr9bWaIYX12P1veY2kuY.jk.GfOQ84I.Cw8ZZ62xHC2taO', NULL, '2024-04-02 07:49:03', '2024-04-02 07:49:03'),
(10, 'Tayyab', 'tayyabshahzad@gmail.com', NULL, '$2y$12$Uh5quI.9ubdThqLQMDxnLuQNTM2dPTdfkBHvObnBrfukQmZ2Oc5E6', NULL, '2024-04-02 17:07:14', '2024-04-02 17:07:14'),
(11, 'Tayyab', 'tayyab.shahzad@gmail.com', NULL, '$2y$12$ZkAaAAeGr/phGYlFDA56xukMVpp8kFv8CzpQZVRYDKX87eeK80HgS', NULL, '2024-04-02 17:11:54', '2024-04-02 17:11:54'),
(12, 'Tayyab Dev', 'tayyab-dev@gmail.com', NULL, '$2y$12$1sxM34XDO64donHcoJFhiuk7lS0GEckYzt7NulcI4IUb3DhiP6AJ.', NULL, '2024-04-02 17:20:39', '2024-04-02 17:20:39'),
(13, 'Tayyab-Dev', 'tayyab-dev1@gmail.com', NULL, '$2y$12$Q4x9x8fhIHzbRtmQTKK.WOKuNJ05rle8rYupeCYLa.2DeZUhs46wC', NULL, '2024-04-02 17:27:47', '2024-04-02 17:27:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cars`
--
ALTER TABLE `cars`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cars_registration_no_unique` (`registration_no`),
  ADD KEY `cars_category_id_foreign` (`category_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cars`
--
ALTER TABLE `cars`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cars`
--
ALTER TABLE `cars`
  ADD CONSTRAINT `cars_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
