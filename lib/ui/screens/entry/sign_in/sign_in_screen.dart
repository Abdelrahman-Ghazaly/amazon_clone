import 'package:amazon_clone/services/services.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:amazon_clone/ui/screens/entry/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Authentication auth = Authentication();
  Size screenSize = Utilities().screenSize;
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenSize.height / 10,
                  child: Hero(
                    tag: 'logo',
                    child: Material(
                      color: Colors.transparent,
                      child: Image.asset('images/Amazon_logo.png'),
                    ),
                  ),
                ),
                Container(
                  height: screenSize.height * 0.55,
                  width: screenSize.width * 0.8,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign-In',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTextField(
                        title: 'E-mail',
                        controller: emailController,
                        hintText: 'Enter Your Email',
                      ),
                      CustomTextField(
                        title: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        hintText: 'Enter Your Password',
                      ),
                      Center(
                        child: CustomButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            String output = await auth.signInUser(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            setState(() {
                              isLoading = false;
                            });

                            if (output != 'Success') {
                              Utilities().showSnackBar(
                                context: context,
                                message: output,
                                color: Colors.redAccent[700]!,
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const Scaffold(
                                      body: SafeArea(child: ScreenLayout()));
                                }),
                              );
                            }
                          },
                          color: kYellowColor,
                          isLoading: isLoading,
                          child: const Text(
                            'Sign-In',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'New to Amazon',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                CustomButton(
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return const SafeArea(child: SignUpScreen());
                        }),
                      );
                    },
                    child: const Text(
                      'Create an Amazon Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
