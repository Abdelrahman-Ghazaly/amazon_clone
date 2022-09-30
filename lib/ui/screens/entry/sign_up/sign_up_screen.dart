import 'package:flutter/material.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens.dart';
import 'package:amazon_clone/ui/screens/entry/widgets/custom_text_field.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/widgets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Size screenSize = Utilities().screenSize;
  Authentication auth = Authentication();
  CloudFirestore cloudFirestore = CloudFirestore();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: screenSize.height / 15,
                  child: Hero(
                    tag: 'logo',
                    child: Material(
                      color: Colors.transparent,
                      child: Image.asset('images/Amazon_logo.png'),
                    ),
                  ),
                ),
                Container(
                  height: screenSize.height * 0.8,
                  width: screenSize.width * 0.8,
                  padding: const EdgeInsets.all(10),
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
                        'Sign-Up',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CustomTextField(
                        title: 'Name',
                        controller: nameController,
                        hintText: 'Enter Your Name',
                      ),
                      CustomTextField(
                        title: 'Address',
                        controller: addressController,
                        hintText: 'Enter Your Address',
                      ),
                      CustomTextField(
                        title: 'E-mail',
                        controller: emailController,
                        hintText: 'Enter Your E-mail',
                      ),
                      CustomTextField(
                        title: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        hintText: 'Enter your Password',
                      ),
                      Center(
                        child: CustomButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });

                            User user = User(
                              name: nameController.text,
                              address: addressController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            String output = await auth.signUpUser(user);

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
                                  return const SignInScreen();
                                }),
                              );
                              Utilities().showSnackBar(
                                context: context,
                                message: output,
                                color: Colors.greenAccent[700]!,
                              );
                            }
                          },
                          color: kYellowColor,
                          isLoading: isLoading,
                          child: const Text(
                            'Sign-Up',
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
                CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return const SafeArea(child: SignInScreen());
                      }),
                    );
                  },
                  color: Colors.grey[400]!,
                  isLoading: false,
                  child: const Text(
                    'Already Have an Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
