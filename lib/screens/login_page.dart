import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:explore/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

import '../constants/appconstants.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/btn_gradient.dart';
import '../widgets/login_field.dart';
import '../widgets/responsive.dart';
import '../widgets/social_button.dart';
import '../widgets/top_bar_contents.dart';
import '../widgets/web_scrollbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _scrollPosition = 0;

  double _opacity = 0;

  late ScrollController _scrollController;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
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
                        /* Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),*/
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
                        const SocialButtonWidget(
                          imagePath: 'assets/svg/g_logo.svg',
                          label: 'Sign In with Google',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SocialButtonWidget(
                          imagePath: 'assets/svg/f_logo.svg',
                          label: 'Sign In with Facebook',
                          horizontalPadding: 90,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Or',
                          style: TextStyle(fontSize: 17),
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
                          controller: passwordController,
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
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => SignUpPage(),
                                ),
                              );
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
