import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recap/constans.dart';
import 'package:recap/pages/register.dart';
import 'package:recap/widgets/custom_button.dart';
import 'package:recap/widgets/custom_textfiled.dart';

class LoginPage extends StatelessWidget {
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
                    "Login",
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
                ontap: () async {
                  try {
                    UserCredential user = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                          email: email!,
                          password: password!,
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Login Succeful",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == "user-not-found") {
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                    }
                    // TODO
                  } catch (e) {
                    print(e);
                  }
                },
                text: "Login",
              ),
              Center(
                child: Row(
                  children: [
                    Text(
                      "Don't have an account ? ",
                      style: TextStyle(
                        color: Colors.white,
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
              Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}
