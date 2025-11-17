import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat_app/pages/chat_page.dart';
import 'package:scholar_chat_app/pages/cubits/chat/chat_cubit.dart';
import 'package:scholar_chat_app/pages/cubits/login/login_cubit.dart';
import 'package:scholar_chat_app/pages/cubits/signup/signup_cubit.dart';
import 'package:scholar_chat_app/pages/login_page.dart';
import 'package:scholar_chat_app/pages/signup_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignupCubit()),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: false),
        routes: {
          SignupPage.route: (context) => SignupPage(),
          LoginPage.route: (context) => LoginPage(),
          ChatPage.route: (context) => ChatPage(),
        },
        initialRoute: SignupPage.route,
      ),
    );
  }
}
