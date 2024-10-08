import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/repository/repository.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'bloc/todo_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => TodoBloc(Repository()),
          child: LoginPage(),
        ));
  }
}

//BlocProvider(
//create: (context) => {
//TodoBloc(Repository()),
//},
//child: LoginPage(),
//),
