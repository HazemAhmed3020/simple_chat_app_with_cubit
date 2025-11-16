import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/pages/cubits/login/login_cubit.dart';
import 'package:scholar_chat_app/pages/signup_page.dart';
import 'package:scholar_chat_app/widgets/custom_button.dart';

import '../widgets/custom_text_field.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const route = '/LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoaded = false;
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            return showSnackBar(context, 'Success');
          }
          else if (state is LoginFailure) {
            return showSnackBar(context, state.errMessage);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is LoginLoading ? true : false,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 180),
                          Image.asset(
                            'assets/images/scholar.png',
                            width: 300,
                            height: 80,
                          ),
                          Text(
                            'Scholar Chat',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Pacifico',
                              color: vPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: vPrimaryColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(hintTxt: 'Email',
                              onChanged: (data) {
                                email = data;
                              }
                          ),
                          SizedBox(height: 7),
                          CustomTextField(
                            showTxt: true,
                            hintTxt: 'Password',
                            onChanged: (data) {
                              password = data;
                            },
                          ),
                          SizedBox(height: 12),
                          CustomButton(
                            txt: 'Sign In',
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).loginAuth(
                                    email: email!, password: password!);
                                Navigator.pushNamed(
                                  context,
                                  ChatPage.route,
                                  arguments: email,
                                );
                              }
                            },
                          ),
                          // SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: vPrimaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pushReplacementNamed(
                                      context,
                                      SignupPage.route,
                                    ),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: vPrimaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showSnackBar(BuildContext context, e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 8,
        padding: EdgeInsets.all(5),
        backgroundColor: vPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        content: Text(
          e.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
