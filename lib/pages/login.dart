import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:recap/constans.dart';
import 'package:recap/pages/chat.dart';
import 'package:recap/pages/register.dart';
import 'package:recap/widgets/custom_button.dart';
import 'package:recap/widgets/custom_textfiled.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  bool isAsync = false;
  String? password;
  bool isPasswordVisible = false; // Changed name for clarity
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        color: Colors.blue,
        progressIndicator: CircularProgressIndicator(color: Colors.blue),
        inAsyncCall: isAsync,
        child: Scaffold(
          backgroundColor: Constans.primiryColor,
          body: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("${Constans.image}"),
                    // Text(
                    //   "Scholar Chat",
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: "Pacifico-Regular",
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(color: Constans.textColor, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Email field - no password toggle needed
                    CustomTextfiled(
                      isScure: false,
                      onChanged: (p0) {
                        email = p0;
                      },
                      enabled: true,
                      hintText: "Email",
                      labelText: "Enter your Email",
                      suffixIcon: null,
                    ),
                    const SizedBox(height: 15),
                    CustomTextfiled(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: isPasswordVisible
                            ? Icon(
                                Icons.visibility_outlined,
                                color: Constans.textColor,
                                size: 20,
                              )
                            : Icon(
                                Icons.visibility_off_outlined,
                                color: Constans.textColor,
                                size: 20,
                              ),
                      ),
                      onChanged: (p0) {
                        password = p0;
                      },
                      enabled: true,
                      hintText: "Password",
                      labelText: "Enter your Password",
                      isScure: !isPasswordVisible, // Hide password when isPasswordVisible is false
                    ),
                    CustomButton(
                      ontap: () async {
                        if (key.currentState!.validate()) {
                          isAsync = true;
                          setState(() {});
                          try {
                            UserCredential user = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Login Successful",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              "${ChatPage.id}",
                              (route) => false,
                              arguments: email,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "user-not-found") {
                              print("No user found for that email.");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'No user found for that email.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (e.code == 'wrong-password') {
                              print("Wrong password provided for that user.");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Wrong password provided for that user.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else if (e.code == "invalid-email") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'The email address is badly formatted.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } else {
                              print("Error: ${e.code}");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error: ${e.code}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } catch (e) {
                            print(e);
                          }
                          isAsync = false;
                          setState(() {});
                        }
                      },
                      text: "Login",
                    ),
                    const SizedBox(height: 20),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                              color: Constans.thirdColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RegisterPage.id);
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Color(0xffCFF4F3)),
                            ),
                          ),
                        ],
                      ),
                    ),
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