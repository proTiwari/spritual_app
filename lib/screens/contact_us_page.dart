import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import '../widgets/web_scrollbar.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
        title:  Image.asset('assets/images/logo-side-crop.png',
            width: screenSize.width / 6,
            height: screenSize.width / 12
        ),
      )
          : PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Container(
            color: Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
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
                      height: screenSize.width / 12
                  ),
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
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: screenSize.height * 0.10,
                    width: screenSize.width,
                    //color: Color(0xfffcb900),
                    color: Colors.deepOrangeAccent,
                  ),
                  Center(
                    child: Column(
                      children: [

                        Text(
                      'Contacts Us',
                      style: TextStyle(
                        fontFamily: 'Electrolize',
                        fontSize: screenSize.width / 40,
                        color: Colors.black54,
                      ),),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              Text(
                                'Need more info?',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 40,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'You can contact us via email or write to any of the Managing Committee or Board members',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 60,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'Address & Contact Details',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 60,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'Jain Society of WaterLoo Inc.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 60,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                '441 Ellesmere Road, Scarborough,\nON M1R 4E5 Canada',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                ),
                              ),
                              //Tel. 1-416-441-2211
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'Tel. 1-416-441-2211',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 90,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'info@jsowcanada.org',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 90,
                                  color: Colors.black54,
                                ),
                              ),

                              //info@jsotcanada.org
                            ],
                          ),
                        ),
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
