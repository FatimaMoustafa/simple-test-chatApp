import 'package:app_chat/constants/colors.dart';
import 'package:app_chat/constants/images.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  static String id = "registerPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        "Register",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextFormField(
                    onChanged: (data){
                      email = data;
                    },
                    hintText: "Email",
                  ),
                  const SizedBox(
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
                      text: "REGISTER",
                      onTap: () async {
                        if(formkey.currentState!.validate()){
                          isLoading = true;
                          setState(() {});
                          try{
                            await registerUser();
                            showSnackerBar(context, "success");
                            Navigator.pop(context);
                          }on FirebaseAuthException catch(ex){
                            if(ex.code == 'weak-password'){
                              showSnackerBar(context, "weak password.");
                            } else if(ex.code == 'email-already-in-use'){
                              showSnackerBar(context, "email already exists.");
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }else{}
                      },
                  ),
                  const SizedBox(
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
                          Navigator.pop(context);
                        },
                        child: Text(
                          " Login",
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
