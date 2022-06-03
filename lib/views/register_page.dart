import 'package:flutter/material.dart';
import 'package:job/constants.dart';
import 'package:job/data/hive_database.dart';
import 'package:job/data/shared_pref.dart';
import 'package:job/models/Job.dart';
import 'package:job/views/login_page.dart';
import 'package:job/views/home.dart';
import 'package:job/views/tampil_profile.dart';


class RegisterPage extends StatefulWidget {
  final Job? job;
  final int? index;

  const RegisterPage({Key? key, this.job, this.index}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {

  final usn_controller = TextEditingController();
  final email_controller = TextEditingController();
  final pass_controller = TextEditingController();

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
                children :[
                  Icon(
                    Icons.add_circle_rounded,
                    size: 100,
                  ),

                  SizedBox(height: 30,),

                  //GREETINGS
                  Text(
                    'Hello!',
                    style: kLoginStyle,
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      '\nEnter your personal details and start journey with us!',
                      textAlign: TextAlign.center,
                      style: kLoginSubtitleStyle,
                    ),
                  ),
                  SizedBox(height: 50,),

                  _formSection(usn_controller, 'Username'),

                  SizedBox(height: 15),

                  _formSection(email_controller, 'Email'),

                  SizedBox(height: 15),

                  _formSection(pass_controller, 'Password'),

                  SizedBox(height: 25,),

                  //SIGN UP BUTTON
                  _buttonSubmit(),


                  SizedBox(height: 25),
                  
                  //text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                        style: kSubtitle2Style,
                      ),
                      Text(' Login',
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

  Widget _buttonSubmit() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 145.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ElevatedButton(
          onPressed: _submitProcess,
          child: Text(
            'Sign In',
            style: kButtonStyle,
          ),
        ),
      ),
    );
  }

  void _submitProcess(){
    String usn = usn_controller.text;
    String email = email_controller.text;
    String pass = pass_controller.text;

    Job job = Job(email: email, username: usn, password: pass);
    // if (isUpdate)
    //   _hd.putNoteAt(index, note);
    // else
    //   _hd.addData(note);
    // Navigator.pop(context);

    HiveDatabase().addData(job);
    // Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

}