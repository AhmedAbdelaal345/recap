import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recap/constans.dart';
import 'package:recap/widgets/custom_button.dart';
import 'package:recap/widgets/custom_textfiled.dart';

class RegisterPage extends StatefulWidget {
  // Use 'static const' for route IDs, though 'String' is fine for now
  static const String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Use TextEditingController for robust input handling
  // Remove String? email; and String? password; as they are not needed directly now
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constans.primiryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/scholar.png"),
              Text(
                "Scholar Chat",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico-Regular",
                  color: Colors.white,
                ),
              ),
              Spacer(flex: 5),
              Row(
                textDirection: TextDirection.ltr,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomTextfiled(
                // **CRITICAL CHANGE: Use controller instead of onChanged**
                controller: _emailController,
                hintText: "Email",
                labelText: "Enter your Email",
              ),
              const SizedBox(height: 15),
              CustomTextfiled(
                // **CRITICAL CHANGE: Use controller instead of onChanged**
                controller: _passwordController,
                hintText: "Password",
                labelText: "Enter your Password",
                isScure: true,
              ),
              Spacer(flex: 3),
              CustomButton(
                text: isLoading ? "Creating Account..." : "Sign Up",
                ontap:
                    isLoading
                        ? null
                        : () async {
                          // Get values directly from controllers, trimming whitespace
                          final String email = _emailController.text.trim();
                          final String password =
                              _passwordController.text.trim();

                          // Validate inputs first
                          if (email.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter your email"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          if (password.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please enter your password"),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          try {
                            FirebaseAuth fire = FirebaseAuth.instance;
                            UserCredential
                            user = await fire.createUserWithEmailAndPassword(
                              email:
                                  email, // Now 'email' is guaranteed to be a non-null String
                              password:
                                  password, // Now 'password' is guaranteed to be a non-null String
                            );

                            print("User created: ${user.user!.email}");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Account created successfully!"),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.pop(
                              context,
                            ); // Or navigate to another page like home
                          } on FirebaseAuthException catch (e) {
                            String message = '';
                            if (e.code == 'email-already-in-use') {
                              message =
                                  'This email is already registered. Try logging in instead.';
                            } else if (e.code == 'weak-password') {
                              message =
                                  'Password is too weak. Use at least 6 characters.';
                            } else if (e.code == 'invalid-email') {
                              message = 'Please enter a valid email address.';
                            } else {
                              message =
                                  'Registration failed: ${e.message ?? "An unknown Firebase error occurred."}';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.red,
                              ),
                            );
                            print(
                              "Firebase Auth Error: ${e.code} - ${e.message}",
                            );
                          } catch (e) {
                            // This catches any *other* exceptions, like network issues or the
                            // `_TypeError` if it somehow still occurs (though it shouldn't with controllers)
                            print("Unexpected error: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "An unexpected error occurred. Please try again.",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
              ),
              Center(
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Added for better centering
                  children: [
                    Text(
                      "Do you have an account ? ",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Color(0xffCFF4F3)),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
