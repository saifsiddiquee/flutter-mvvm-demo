import 'package:flutter/material.dart';
import 'login_viewmodel.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BodyWidget(),
    );
  }
}

class BodyWidget extends StatefulWidget {
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final loginViewModel = LoginViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      loginViewModel.emailSink.add(emailController.text);
    });

    passController.addListener(() {
      loginViewModel.passSink.add(passController.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    loginViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
            stream: loginViewModel.emailStream,
            builder: (context, snapshot) {
              return TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: "example@gmail.com",
                    errorText: snapshot.data,
                    labelText: "Email *"),
              );
            },
          ),
          SizedBox(
            height: 40,
          ),
          StreamBuilder<String>(
              stream: loginViewModel.passStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      errorText: snapshot.data,
                      labelText: "Password *"),
                );
              }),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 200,
            height: 45,
            child: StreamBuilder<bool>(
                stream: loginViewModel.btnLoginStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: snapshot.data == true
                        ? () {
                            _showToast(context);
                          }
                        : null,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Login Successful'),
        action: SnackBarAction(
            label: 'Logout', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
