import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import '../widgets/web_scrollbar.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  var selectedPayment = "VISA";
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
        ): PreferredSize(
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24,vertical: 50),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Donation',
                              style: TextStyle(
                                fontFamily: 'Electrolize',
                                fontSize: screenSize.width / 40,
                                color: Colors.black54,
                              ),),
                            SizedBox(height: 12),
                            Text(
                              'Get your name on the brick donation wall in our 441 Ellesmere Cultural Center.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 60,
                                  color: Colors.black54,
                                )
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Method',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                )
                            ),
                            SizedBox(height: 12),
                            _selectPayment('VISA', 'assets/images/visa.png'),
                            SizedBox(height: 16),
                            _selectPayment('Master Card', 'assets/images/mc.png'),
                            SizedBox(height: 16),
                            _selectPayment('Apple Pay', 'assets/images/bwa.png'),
                          ],
                        ),
                        SizedBox(height: 50),
                        ElevatedButton(
                          //style: buttonPrimary,
                          onPressed: () {},
                          child: Text(
                            'Support Now',
                            //style: labelPrimary,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Terms & Conditions',
                            //style: labelSecondary,
                          ),
                        ),
                      ],
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

  Widget _selectPayment(String title, String image) {
    return InkWell(
      onTap: () {
        selectPayment(title);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: title == selectedPayment ? Colors.white : Colors.transparent,
          border: title == selectedPayment
              ? Border.all(width: 1, color: Colors.transparent)
              : Border.all(width: 1, color: Colors.grey),
        ),
        child: Container(
          width: double.infinity,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Text(
                  title,
                  //style: title == selectedPayment ? paymentSelected : payment,
                ),
                Spacer(),
                Image.asset(image, height: 23),
              ],
            ),
          ),
        ),
      ),
    );
  }

  selectPayment(title) {
    setState(() {
      selectedPayment = title;
    });
  }
}
