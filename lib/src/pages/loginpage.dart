import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerNickname = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
          nickname: _controllerNickname.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Auth');
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    double width,
    double height,
    IconData icona,
  ) {
    return TextField(
      keyboardType:
          title == 'Email' ? TextInputType.emailAddress : TextInputType.text,
      controller: controller,
      obscureText: title == 'Password' ? true : false,
      decoration: InputDecoration(
        prefixIcon: Icon(icona),
        fillColor: Colors.white,
        hintText: title,
        hintStyle: const TextStyle(color: Colors.black, fontSize: 20),
        filled: true,
        contentPadding: EdgeInsets.symmetric(
            horizontal: width * 0.07, vertical: width * 0.05),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : '$errorMessage');
  }

  Widget _submitButton(width, height) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                vertical: width * 0.02, horizontal: width * 0.05)),
            elevation: MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPassword,
        child: Text(
          isLogin ? 'Login' : 'Sign up',
          style: TextStyle(fontSize: width * 0.08),
        ));
  }

  Widget _loginOrRegister(width, height) {
    return Visibility(
        visible: height < 500 ? false : true,
        child: Column(
          children: [
            Text(
              isLogin ? 'Non sei ancora registrato?' : 'Hai già un account',
              style: TextStyle(color: Colors.white, fontSize: width * 0.04),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin ? 'Registrati' : 'Esegui login',
                style: TextStyle(color: Colors.white, fontSize: width * 0.06),
              ),
            )
          ],
        ));
  }

  Widget login(width, height) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: height,
          color: Colors.deepPurpleAccent,
          padding:
              EdgeInsets.fromLTRB(width * 0.1, width * 0.1, width * 0.1, 0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Image(
                alignment: Alignment.bottomCenter,
                image: const AssetImage('assets/logo.png'),
                width: width * 0.9,
                height: height * 0.09,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                textAlign: TextAlign.center,
                'Sign in',
                style: TextStyle(
                  fontSize: width * 0.1,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              _entryField('Email', _controllerEmail, width, height,
                  Icons.email_outlined),
              SizedBox(
                height: height * 0.03,
              ),
              _entryField(
                  'Password', _controllerPassword, width, height, Icons.key),
              _errorMessage(),
              SizedBox(
                height: height * 0.04,
              ),
              _submitButton(width, height),
              SizedBox(
                height: height * 0.04,
              ),
              _loginOrRegister(width, height)
            ],
          )),
    );
  }

  Widget register(width, height) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          height: height,
          color: Colors.deepPurpleAccent,
          padding:
              EdgeInsets.fromLTRB(width * 0.1, width * 0.1, width * 0.1, 0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Image(
                alignment: Alignment.bottomCenter,
                image: const AssetImage('assets/logo.png'),
                width: width * 0.9,
                height: height * 0.09,
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                textAlign: TextAlign.center,
                'Sign up',
                style: TextStyle(
                  fontSize: width * 0.1,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              _entryField('Nickname', _controllerNickname, width, height,
                  Icons.account_circle_outlined),
              SizedBox(
                height: height * 0.03,
              ),
              _entryField(
                  'Email', _controllerEmail, width, height, Icons.mail_outline),
              SizedBox(
                height: height * 0.03,
              ),
              _entryField(
                  'Password', _controllerPassword, width, height, Icons.key),
              _errorMessage(),
              SizedBox(
                height: height * 0.04,
              ),
              _submitButton(width, height),
              SizedBox(
                height: height * 0.04,
              ),
              _loginOrRegister(width, height)
            ],
          )),
    );
  }

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLogin ? login(width, height) : register(width, height);
  }
}
