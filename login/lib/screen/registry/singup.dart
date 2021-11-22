import 'package:flutter/material.dart';
import 'package:login/auth/authentication.dart';
import 'package:login/models/cloudfirebase_userinfo.dart';
import 'package:login/screen/home.dart';
import 'package:login/screen/registry/login.dart';
import 'package:login/validation/validatior.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: const Color(0xFF2C3E50),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              const SizedBox(height: 20),
              // logo
              Column(
                children: [
                  Container(
                    height: 130.0,
                    margin: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Image.asset('assets/images/ust1.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SignupForm(),
              ),


            Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Hesabınız var mı?  ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        ' Login',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
            )

                  ],
                ),
          ),
        ),
      );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State with LoginValidationMixin {
  final _formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String name;
  bool _obscureText = true;

  bool agree = false;

  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(100.0),
      ),
    );

    var space = const SizedBox(height: 10);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // email
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: 'Email',
                border: border),
            validator: validateEmailName,
            onSaved: (val) {
              email = val!;
            },
            keyboardType: TextInputType.emailAddress,
          ),

          space,

          // password
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: pass,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              border: border,
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
          //  obscureText: true,
            validator: validatePassword,
          ),
          space,
          // confirm passwords
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outline),
              border: border,
            ),
            obscureText: true,
            validator: (value) {
              if (value != pass.text) {
                return 'password not match';
              }
              return null;
            },
          ),
          space,
          // name
          TextFormField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: const Icon(Icons.account_circle),
              border: border,
            ),
            validator: validateFirstName,
            onSaved: (val) {
              name = val!;
            },
          ),

          space,
          space,

          // signUP button
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                AuthenticationHelper()
                    .signUp(email: email, password: password)
                    .then((result) {
                  if (result != null) {
                    print("///////////////////");
                    CloudFirestore().createUserData(result, name, email);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  } else {
                    Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Kayıt sırasında hata oluştu, tekrar deneyin",
                        style: TextStyle(fontSize: 16),
                      ),
                    ));
                  }
                });
              }
            },
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            color: Colors.blue[400],
            textColor: Colors.white,
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
