import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pingo/Screens/SignIn.dart';
import 'package:provider/provider.dart';
import '../Consts/Consts.dart';
import '../Provider/AuthProvider.dart';
import '../utils.dart';
import 'Components/MyButton.dart';


class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // text editing controllers
  final usernameController = TextEditingController();
  final usermailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool passicon = true;
  bool _isLoading = false;

  Utils ut = Utils();

  // sign user in method
  void signUserUp() async {
    if (!_form.currentState!.validate()) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      var response = await context.read<AuthProvider>().signUp(
        usernameController.text,
        usermailController.text,
        confirmpasswordController.text,
      );

      response == null ? null :
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => SignInScreen()
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // username textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: usernameController,
                      decoration: buildInputDecoration(
                          hint: 'Enter your Name',
                          onTap: null,
                          ),
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required Field';
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          val = usernameController.text;
                        });
                      },
                      obscureText: false,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // usermail textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: usermailController,
                      decoration: buildInputDecoration(
                        hint: 'Enter your Email',
                          onTap: null,
                          ),
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required Field';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Enter a valid Email';
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          val = usermailController.text;
                        });
                      },
                      obscureText: false,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: passwordController,
                      decoration: buildInputDecoration(
                        hint: 'Enter your Password',
                        onTap: () {
                          setState(() {
                      passicon = !passicon;
                      });
                        },
                        icon: passicon
                      ),
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required Field';
                        }
                        else if (!ut.passvalidateStructure(value)) {
                          return 'Must contain at least one number and one uppercase and lowercase letter and one special character,'
                              ' and at least 8 or more characters';
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          val = passwordController.text;
                        });
                      },
                      obscureText: passicon == true ? true : false,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // confirm password textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: confirmpasswordController,
                      decoration: buildInputDecoration(
                          hint: 'Confirm your Password',
                          onTap: null,
                      ),
                      enabled: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required Field';
                        }
                        else if (passwordController.text != value) {
                          return 'Password didn\'t match!!' ;
                        }
                        else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          val = confirmpasswordController.text;
                        });
                      },
                      obscureText: true,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // sign up button
                  MyButton(
                    isloading: _isLoading,
                    onTap: signUserUp,
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> SignInScreen()
                          ));
                        },
                        child: const Text(
                          ' Login',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}








