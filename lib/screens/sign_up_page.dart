import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/appconstants.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/btn_gradient.dart';
import '../widgets/login_field.dart';
import '../widgets/responsive.dart';
import '../widgets/social_button.dart';
import '../widgets/top_bar_contents.dart';
import '../widgets/web_scrollbar.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  double _scrollPosition = 0;

  double _opacity = 0;

  late ScrollController _scrollController;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  void _registerUser() async {
    try {
      print("here 1");
      final newUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("here 2");

      if (newUser != null) {
        print("here 3");
        await FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.user!.uid)
            .set({
          'verified': false,
          'email': emailController.text,
          'name': nameController.text,
          'age': ageController.text,
          'role': "user",
          'registrationDate': DateTime.now(),
        });
        print("here 4");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Account created successfully',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 54, 244, 168),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
      print("here 5");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$e',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
      print('Error occurred during registration: $e');
      // Handle registration errors (e.g., invalid email, weak password, etc.).
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor:
                  Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
              elevation: 0,
              centerTitle: true,
              actions: [
                Visibility(
                  visible: false,
                  child: IconButton(
                    icon: Icon(Icons.brightness_6),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      EasyDynamicTheme.of(context).changeTheme();
                    },
                  ),
                ),
              ],
              title: Image.asset('assets/images/logo-side-crop.png',
                  width: screenSize.width / 6, height: screenSize.width / 12),
            )
          : PreferredSize(
              preferredSize: Size(screenSize.width, 1000),
              child: PreferredSize(
                preferredSize: Size(screenSize.width, 1000),
                child: Container(
                  color:
                      Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/logo-side-crop.png',
                            width: screenSize.width / 6,
                            height: screenSize.width / 12),
                        SizedBox(
                          width: screenSize.width / 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      body: WebScrollbar(
        color: Colors.blueGrey,
        backgroundColor: Colors.blueGrey.withOpacity(0.3),
        width: 10,
        heightFraction: 0.3,
        controller: _scrollController,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: screenSize.height * 0.30,
                    width: screenSize.width,
                    color: Color(0xfffcb900),
                  ),
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Sign In.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.transparent),
                        ),
                        const SizedBox(height: 50),
                        LoginField(
                          controller: nameController,
                          hintText: 'First Name & Last Name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginField(
                          controller: passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginField(
                          controller: ageController,
                          hintText: 'Age',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        LoginField(
                          controller: emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        LoginField(
                          controller: confirmPasswordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const BtnGradient(),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.gradient1,
                                  AppColors.gradient2,
                                  AppColors.gradient3,
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                          child: ElevatedButton(
                            onPressed: () {
                              if (confirmPasswordController.text ==
                                  passwordController.text) {
                                print('password match');
                                if (nameController.text.isNotEmpty &&
                                    ageController.text.isNotEmpty &&
                                    emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty &&
                                    confirmPasswordController.text.isNotEmpty) {
                                  // how to create user with email password in firebase flutter
                                  _registerUser();
                                } else {
                                  print('please fill all the fields');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please fill all the fields',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                // Navigator.pushNamed(context, '/home');
                              } else {
                                print('password does not match');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Password does not match',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              fixedSize: const Size(
                                375,
                                60,
                              ),
                            ),
                            child: const Text(
                              'Become A Member',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
