import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:recap/constans.dart';
import 'package:recap/widgets/custom_button.dart';
import 'package:recap/widgets/custom_textfiled.dart';

class RegisterPage extends StatefulWidget {
  static const String id = 'RegisterPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;
  // Removed isAsync as isLoading can serve the same purpose for ModalProgressHUD


  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: isLoading, // Use isLoading directly
        color: Colors.blue, // Added from the second code
        progressIndicator: CircularProgressIndicator(
          color: Colors.blue,
        ), // Added from the second code
        child: Scaffold(
          backgroundColor: Constans.primiryColor,
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  // Changed to ListView for simpler scrolling handling
                  // Removed LayoutBuilder, ConstrainedBox, IntrinsicHeight
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      Constans.image,
                      fit: BoxFit.scaleDown,
                    ),

                    // Center(
                    //   child: Text(
                    //     "Scholar Chat",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //       fontFamily: "Pacifico-Regular",
                    //       color: Constans.thirdColor,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 40),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(color: Constans.textColor, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextfiled(
                      isScure: false,
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: "Email",
                      labelText: "Enter your Email",
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 15),
                    CustomTextfiled(
                     suffixIcon: IconButton(
                       onPressed: () {
                         setState(() {
                           isPasswordVisible = !isPasswordVisible;
                         });
                       },
                       icon: !isPasswordVisible
                           ? Icon(
                         Icons.visibility_outlined,
                         color: Constans.textColor,
                         size: 20,
                       )
                           : Icon(
                         Icons.visibility_off_outlined,
                         color: Constans.textColor
                         ,
                         size: 20,
                       ),
                     ),

                      onChanged: (data) {
                        password = data;
                      },
                      hintText: "Password",
                      labelText: "Enter your Password",
                      isScure: isPasswordVisible,
                      enabled: !isLoading,

                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: isLoading ? "Creating Account..." : "Sign Up",
                      ontap:
                          isLoading
                              ? null
                              : () async {
                                if (formKey.currentState!.validate()) {
                                  if (email == null || password == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Email and password cannot be empty.",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return; // Exit if fields are empty
                                  }

                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                          email: email!,
                                          password: password!,
                                        );
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Account created successfully!",
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.pop(context);
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    String errorMessage =
                                        'Registration failed: ${e.message}';
                                    if (e.code == 'email-already-in-use') {
                                      List<String> providers =
                                          await FirebaseAuth.instance
                                              .fetchSignInMethodsForEmail(
                                                email!,
                                              ); // Await this call
                                      String existingProviders = providers.join(
                                        ', ',
                                      );
                                      errorMessage =
                                          'This email is already registered. Try signing in using: $existingProviders';
                                    } else if (e.code == 'weak-password') {
                                      errorMessage =
                                          'The password provided is too weak.';
                                    } else if (e.code == 'invalid-email') {
                                      errorMessage =
                                          'The email address is not valid.';
                                    }
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(errorMessage),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'An unexpected error occurred: $e',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do you have an account ? ",
                            style: TextStyle(
                              color: Constans.thirdColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          InkWell(
                            onTap:
                                isLoading
                                    ? null
                                    : () {
                                      Navigator.pop(context);
                                    },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color:
                                    isLoading ? Colors.grey : Color(0xffCFF4F3),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
