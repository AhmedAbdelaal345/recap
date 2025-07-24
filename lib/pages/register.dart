import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recap/constans.dart';
import 'package:recap/widgets/custom_button.dart';
import 'package:recap/widgets/custom_textfiled.dart';

class RegisterPage extends StatelessWidget {
  String registerId = 'RegisterPage';
  String? email;
  String? password;
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
                onChanged: (p0) {
                  email = p0;
                },
                hintText: "Email",
                labelText: "Enter your Email",
              ),
              const SizedBox(height: 15),
              CustomTextfiled(
                onChanged: (p0) {
                  password = p0;
                },
                hintText: "Password",
                labelText: "Enter your Password",
                isScure: true,
              ),
              Spacer(flex: 3),
              CustomButton(
                text: "Sign Up",
                ontap: () async {
                  try {
                    // Method 1: Force disable app verification
                    await FirebaseAuth.instance.setSettings(
                      appVerificationDisabledForTesting: true,
                      forceRecaptchaFlow: false,
                    );

                    FirebaseAuth fire = FirebaseAuth.instance;
                    UserCredential user = await fire
                        .createUserWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                    print("User created: ${user.user!.email}");
                    print("UID: ${user.user!.uid}");
                  } catch (e) {
                    print("Error: $e");
                  }
                },
              ),
              Center(
                child: Row(
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
