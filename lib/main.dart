import 'package:assignment/widget/btn_widget.dart';
import 'package:assignment/widget/txtfielld_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'HomePage.dart';
import 'model/employee_model.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(PeopleAdapter());
  await Hive.openBox('peopleBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});


  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late TextEditingController textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    textEditingController=TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please Enter Password to Login',
            ),
            TextFieldWidget(textEditingController: textEditingController, text: 'Password', iconName: Icons.lock_outline,),
            button_widget(fun: (){if(textEditingController.text=='ninjaCoder') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }else{
              final snackBar = SnackBar(
                content: Row(
                  children: const [
                    Icon(Icons.cancel_outlined,color: Colors.white,),
                    SizedBox(width: 15,),
                    Text('Please enter the Correct Password'),
                  ],
                ),
                backgroundColor: (Colors.red),
                action: SnackBarAction(
                  label: 'dismiss',
                  textColor: Colors.white,
                  onPressed: () {
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }}, text: 'Login', color: Colors.blue,textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}

