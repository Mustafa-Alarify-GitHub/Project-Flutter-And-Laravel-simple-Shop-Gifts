# Mini Gift Store

### Project Description
A mini gift store project that provides a seamless shopping experience for users. 
- **Backend:** Laravel 10 for building a robust RESTful API.
- **Frontend:** Flutter for a fully integrated and high-performance mobile app.

---

## Requirements

### **Backend (Laravel)**
1. PHP 8.1 or later.
2. Composer.
3. MySQL or PostgreSQL database.
4. Local server (e.g., XAMPP or Laravel Sail).

### **Frontend (Flutter)**
1. Flutter SDK.
2. Code editor (e.g., VS Code or Android Studio).

---

## Installation Steps

### 1. Setting up the Backend (Laravel)
1. Clone the repository:
   ```bash
   git clone https://github.com/username/mini-gift-store.git
   cd mini-gift-store/backend
   ```
2. Install the required packages:
   ```bash
   composer install
   ```
3. Copy the environment file:
   ```bash
   cp .env.example .env
   ```
4. Update the database configuration in the `.env` file:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=your_database_name
   DB_USERNAME=your_username
   DB_PASSWORD=your_password
   ```
5. Generate the application key:
   ```bash
   php artisan key:generate
   ```
6. Run database migrations:
   ```bash
   php artisan migrate
   ```
7. Start the local server:
   ```bash
   php artisan serve
   ```

---

### 2. Setting up the Frontend (Flutter)
1. Navigate to the frontend directory:
   ```bash
   cd ../frontend
   ```
2. Install the required packages:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---

## Additional Notes
- Ensure **CORS** is configured properly in Laravel if accessing the application over the network.
- Install the appropriate Flutter packages based on the target platform (Android or iOS).

---

**Enjoy building and running your mini gift store project!**

