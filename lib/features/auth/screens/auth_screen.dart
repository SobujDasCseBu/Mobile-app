import 'package:first_project/common/widgets/custom_button.dart';
import 'package:first_project/common/widgets/custom_textfield.dart';
import 'package:first_project/constants/global_variables.dart';
import 'package:first_project/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth {
  sigin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  Future<void> signUpUser() async {
    authService.signUpUser(
        context: context,
        password: _passwordController.text,
        name: _nameController.text,
        email: _emailController.text);
  }

  Future<void> signInUser() async {
    authService.signInUser(
        context: context,
        password: _passwordController.text,
        email: _emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Create Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CutsomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CutsomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CutsomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: 'Sign Up',
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            })
                      ],
                    )),
              ),
            ListTile(
              tileColor: _auth == Auth.sigin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Sign_In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.sigin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.sigin)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CutsomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CutsomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            text: 'Sign In',
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            })
                      ],
                    )),
              ),
          ],
        ),
      )),
    );
  }
}
