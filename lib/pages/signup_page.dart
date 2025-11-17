import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_app/constants.dart';
import 'package:scholar_chat_app/pages/cubits/signup/signup_cubit.dart';
import 'package:scholar_chat_app/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'chat_page.dart';
import 'login_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const route = '/SignupPage';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? email;
  String? password;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            showSnackBar(context, 'Success');
            Navigator.pushNamed(context, ChatPage.route,
                arguments: email);
          }
          else if (state is SignupFailure) {
            return showSnackBar(context, state.errMessage.substring(37));
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is SignupLoading ? true : false,
            child: Scaffold(
              backgroundColor: kPrimaryColor,
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 180),
                          Image.asset(
                            'assets/images/scholar.png',
                            width: 300,
                            height: 90,
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
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: vPrimaryColor,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 20),
                          CustomTextField(
                            hintTxt: 'Email',
                            onChanged: (data) {
                              email = data;
                            },
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
                              txt: 'Sign Up',
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<SignupCubit>(context)
                                      .signupAuth(
                                      email: email!, password: password!);

                                }
                              }
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
                                      LoginPage.route,
                                    ),
                                child: Text(
                                  "Login",
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
        padding: EdgeInsets.all(10),
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