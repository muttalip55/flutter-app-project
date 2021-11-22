import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/auth/authentication.dart';
import 'package:login/screen/home.dart';
import 'package:login/screen/registry/singup.dart';
import 'package:login/validation/validatior.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          color: const Color(0xFF2C3E50),
          child: ListView(
            children: <Widget>[
              Container(
                height: 140.0,
                margin: const EdgeInsets.only(top: 50.0),
                child: Center(
                  child: Image.asset('assets/images/ust1.png'),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: LoginForm(),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text(
                     'Hesabınız yok mu? ',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                     ),
                   ),

                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: const Text(
                        'Yeni Hesap Oluşturun!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                         // fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with LoginValidationMixin {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email_outlined),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),
            validator: validateEmailName,
            onSaved: (val) {
              email = val!;
            },
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 20,
          ),

          // password
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
            obscureText: _obscureText,
            onSaved: (val) {
              password = val!;
            },
            validator: validatePassword,
          ),

          const SizedBox(height: 30),

          SizedBox(
            height: 54,
            width: 184,
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  AuthenticationHelper()
                      .signIn(email: email, password: password)
                      .then((result) {
                    if (result != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home(userid: result)));
                    } else {
                      Scaffold.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          "Giriş sırasında hata oluştu",
                          style: TextStyle(fontSize: 16),
                        ),
                      ));
                    }
                  });
                }
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0))),
              color: Colors.blue[400],
              textColor: Colors.white,
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
