import 'package:flutter/material.dart';
import 'package:job/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:job/data/hive_database.dart';
import 'package:job/data/shared_pref.dart';
import 'package:job/views/home.dart';
import 'package:job/models/Job.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoginSuccess = false;
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  HiveDatabase _hd = HiveDatabase();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    SharedPref().getLoginStatus().then((status) {
      if (status) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_circle_rounded,
                  size: 100,
                ),

                SizedBox(height: 30,),

                //GREETINGS
                Text(
                  'Hello Again!',
                  style: kLoginStyle,
                ),
                SizedBox(height: 10,),
                Text(
                  '\nWelcome back, you\'ve been missed!',
                  style: kLoginSubtitleStyle,
                ),

                SizedBox(height: 50,),

                _formSection(username_controller, 'Username'),
                SizedBox(height: 15),
                _formSection(password_controller, 'Password'),

                SizedBox(height: 25,),

                _buttonSubmit(),


                SizedBox(height: 25),

                //text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a Member?',
                      style: kSubtitle2Style,
                    ),
                    Text(' Register Now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonSubmit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 145.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: _loginProcess,
          child: Text(
            'Sign In',
            style: kButtonStyle,
          ),
        ),
      ),
    );
  }

  void _loginProcess() {
    String text = "";
    String username = username_controller.text;
    String password = password_controller.text;

    if (username.isNotEmpty || password.isNotEmpty) {
      if (username == "Gisa" && password == "123") {
        setState(() {
          text = "Login Success";
          isLoginSuccess = true;
        });
        _loginProcess2(context, username);
      } else {
        setState(() {
          text = "Login Failed";
          isLoginSuccess = false;
        });
      }
      print("isLoginSuccess : $isLoginSuccess");
      SnackBar snackBar = SnackBar(
        content: Text(text),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    child: const Text('Login');
  }

    Widget _formSection(dynamic text_controller, String label) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: TextField(
              controller: text_controller,
              style: kLoginSubtitleStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: label,
              ),
            ),
          ),
        ),
      );
    }

  void _loginProcess2(BuildContext context, String username) {
    SharedPref().setLogin(username);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
    }
  }

