# Tezda

A simple and elegant Flutter e-commerce application using [FakeStoreAPI](https://fakestoreapi.com) for user authentication, product management, and more. This app features light and dark modes, user-friendly navigation, and optimized performance.

---

## **Features**

1. **Efficient Data Handling**:
   - Fetch and display product data from the mock API seamlessly.
   - Handle smooth scrolling and optimized image loading.

2. **Secure Authentication**:
   - User registration and login with session expiration handling.
   - Manage user authentication state securely using Hive Storage.

3. **Product Management**:
   - View a list of products fetched from the API.
   - Navigate between product listing and detailed product views.
   - Mark products as favorites and save them locally using Hive.

4. **User Profile Management**:
   - Intuitive and visually appealing profile screen.
   - Update user details with ease.
   - Manage and display user-specific functionality.

5. **Dark Mode and Light Mode**:
   - Full support for both dark and light themes for a better user experience.

6. **Modern UI/UX**:
   - Clean and user-friendly design for product detail and profile management screens.
   - Smooth transitions between screens using Riverpod for state management.

---

## **Technologies Used**

- **Flutter**: Framework for building the application.
- **Riverpod**: State management for a scalable and maintainable architecture.
- **Hive**: Local storage for caching user data and favorite products.
- **FakeStoreAPI**: Backend for product data and user authentication.

---

## **How to Launch the App**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/tezda.git
   cd tezda
   ```

2. **Install Flutter Dependencies**:
   Ensure you have Flutter installed. Follow the [official installation guide](https://docs.flutter.dev/get-started/install).

   Then, run:
   ```bash
   flutter pub get
   ```

3. **Run the App**:
   - Connect a physical device or start an emulator.
   - Run the following command:
     ```bash
     flutter run
     ```
   - Use `flutter run --release` for a production-ready build.

4. **Troubleshooting**:
   - Ensure you have the correct SDK version installed.
   - Run `flutter doctor` to check for missing dependencies or configurations.

---

## **App Overview**

### **Authentication**
- Users can register, log in, and manage their sessions.
- Secure state management ensures authentication tokens are properly handled.

### **Products**
- View a list of products fetched dynamically from the API.
- Tap on a product to see detailed information such as description, price, and category.

### **Favorites**
- Mark products as favorites with a single tap.
- Favorites are stored locally using Hive for offline access.

### **Profile Management**
- View and update user details like username, email, and address.

### **UI/UX**
- Modern design with smooth transitions.
- Fully functional dark mode for better accessibility.

---

## **Core Functionality**

1. Fetching and displaying data efficiently from the FakeStoreAPI.
2. Seamless navigation between product listings and details.
3. Visually appealing UI for product detail and user profile screens.
4. Secure authentication mechanisms to protect user data.
5. Handling session expiration and managing authentication state.
6. Storing user-specific preferences, such as favorites, using Hive.
7. Light and dark mode toggle for an enhanced user experience.

---

## **Contributing**

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature name"
   ```
4. Push your branch:
   ```bash
   git push origin feature-name
   ```
5. Submit a pull request for review.




