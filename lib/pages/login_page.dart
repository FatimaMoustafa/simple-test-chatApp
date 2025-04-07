import 'package:app_chat/constants/colors.dart';
import 'package:app_chat/constants/images.dart';
import 'package:app_chat/pages/chat_page.dart';
import 'package:app_chat/pages/register_page.dart';
import 'package:app_chat/widgets/custom_button.dart';
import 'package:app_chat/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id = "loginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: PrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Spacer(flex: 2,),
                  Image.asset(Logo),
                  Text(
                    "Scholar Chat",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'pacifico'
                    ),
                  ),
                  Spacer(flex: 1,),
                  Row(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data){
                      email = data;
                    },
                    hintText: "Email",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    obsecureText: true,
                    onChanged: (data){
                      password = data;
                    },
                    hintText: "Password",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () async {
                      if(formkey.currentState!.validate()){
                        isLoading = true;
                        setState(() {});
                        try{
                          await loginUser();
                          showSnackerBar(context, "success");
                          Navigator.pushNamed(context, ChatPage.id, arguments: email);
                        }on FirebaseAuthException catch(ex){
                          if(ex.code == 'user-not-found'){
                            showSnackerBar(context, 'No user found for that email.');
                          } else if(ex.code == 'wrong-password'){
                            showSnackerBar(context, 'Wrong password provided for that user.');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      }else{}
                    },
                    text: "LOGIN",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "don't have an account?",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                            " Register",
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(flex: 3,),
                ],
              ),
            ),
          ),
        ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
