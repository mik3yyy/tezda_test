# Tezda

A simple and elegant Flutter e-commerce application using [FakeStoreAPI](https://fakestoreapi.com) for user authentication, product management, and more. This app features light and dark modes, user-friendly navigation, and optimized performance.

---

## **Design Choices**

1. **Onboarding with PageView**:
   - I used `PageView` for the onboarding screen to allow users to easily swipe left and right, making it intuitive to navigate through the details of the application.
   - This approach ensures that users can quickly learn about the app’s features without feeling overwhelmed.

2. **Login Screen Placement**:
   - After the onboarding screen, the user is directed to the login screen rather than the sign-up screen. This decision was made because most users are likely to log in rather than sign up, as sign-ups typically happen only once.

3. **Product Listing with ListTile**:
   - The home screen displays products using `ListTile` instead of a `GridView`. This decision was driven by the length of many product names, which are often too long for a grid format. Using `ListTile` ensures the titles are fully visible, reducing the need for users to open the product detail page just to read the product name.

4. **Hero Animation for Product Images**:
   - I implemented `Hero` animations on product images to add a touch of polish and provide a smooth transition between the home screen and the product detail screen. This enhances the user experience by making navigation feel more dynamic and engaging.

5. **FadeTransition for Main Screens**:
   - A `FadeTransition` was added to the main screens to create a consistent and smooth visual theme as users navigate through the app.

6. **Log-Out Confirmation Dialog**:
   - An "Are you sure?" dialog box was implemented for the log-out action. This prevents accidental log-outs and gives users a chance to rethink their decision.

7. **Color Palette and Branding**:
   - Yellow was chosen as the primary color for Tezda’s branding. Yellow is an excellent choice for e-commerce applications because:
     - It is associated with optimism, energy, and attention.
     - It draws the user’s focus, making CTAs (Call-to-Actions) like "Buy Now" or "Add to Cart" more prominent.

---

## **Challenges Faced**

1. **Profile Management**:
   - The API login endpoint only returns a token without any user details.
   - Additionally, the API does not provide a way to use the token to fetch user information. To address this, I explored the API documentation, identified the user ID, and used the "Get Single User" endpoint to fetch the user's profile details.

2. **Session Management**:
   - The API did not provide a session duration to manage user sessions. I integrated my own session control mechanism during login by associating a token expiration time with the user’s session.

3. **API Constraints on Geolocation**:
   - The API's sign-up endpoint required latitude (`lat`) and longitude (`long`) fields for the user’s address.
   - Since integrating geolocation services was beyond the project’s scope, I used static values for these fields. However, I successfully demonstrated my ability to handle data input from the user interface to the backend.

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




