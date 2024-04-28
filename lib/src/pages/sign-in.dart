import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_home_app/src/pages/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign-In Form',
          style: TextStyle(fontFamily: 'sans-serif'), // Removed AppleAuthProvider import
        ),
        backgroundColor: Color(0xff9A7265),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 620,
            width: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DrawerHeader(
                    child: GestureDetector(
                      
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.black, // Removed custom color
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Sign in using your email and password',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Color(0xff9A7265)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Color(0xff9A7265)),
                          ),
                          labelText: 'Email',
                          hintText: 'Enter Your Email',
                          labelStyle: TextStyle(
                            color: Color(0xff9A7265),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff9A7265),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Color(0xff9A7265)),
                        ),
                        labelText: 'Password',
                        hintText: 'Enter Your Password',
                        labelStyle: TextStyle(
                          color: Color(0xff9A7265),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xff9A7265),
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Color(0xff9A7265),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 3, color: Color(0xff9A7265)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 19),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9A7265),
                      fixedSize: Size(220, 50),
                    ),
                    onPressed: () async {
                      final auth = FirebaseAuth.instance;
                      try {
                        final userCredential = await auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        // Handle successful sign-in (navigate to main screen)
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                          // Show an error dialog for user not found
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('No user found for that email.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          // Show an error dialog for wrong password
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Wrong password provided for that user.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          print(e.code); // Log other errors
                          // Handle other FirebaseAuthExceptions
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
