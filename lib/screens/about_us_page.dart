import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import '../widgets/web_scrollbar.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
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
                          'About Us',
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
                                'The Jain Society of Waterloo (JSOW) was established in 1974 by a group of Individuals with the aim of promoting cultural and community services to Jain individuals who have come into the country.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'JSOW was registered as a non-profit organization in 1974, with one important mandate; to practice, promote and teach Jainism. JSOW is one of the first Jain organizations established in Canada and fifth in North America. Its mandate is not only to promote Jain principles and practice, but also to provide a place of worship for the Jain community in greater Waterloo area.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'In 1983 JSOW bought its first home, a small community hall on Parklawn Ave, in Etobicoke for \$110,000.00. Community hall was about 2000 sq.ft sufficient for the members at that time. There were 50-75 Jain families who helped pay for the community hall. Over the next few years the work of the community spread and the need for a bigger community hall arose.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'From humble beginnings stated by a few families in 1974, with a vision to have a common community center to promote ideas, teaching and a place to gather and provide social support to both the adults and children coming into the Country the Community has now grown to over 1200 families.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                'The hard work and dedication of all our members promoting a better society has been reflected over the years through many contributions, such as:',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 80,
                                  color: Colors.black54,
                                ),
                              ),
                              //Tel. 1-416-441-2211
                              SizedBox(height: screenSize.height / 20),
                              Text(
                                '* Pathshala (“Sunday School”) was started to teach children about Jainism and the Jain way of life. \n * Swadhyay classes every month teaching spiritual knowledge commenenced in 2003.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 90,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '* Raised funds to build a school, for the victims of 2000 earthquake in Kutch, India \n * Showcased various pieces of Jain Art on the life of Bhagwan Mahavir at Waterloo Harbour Front Center in celebration of 2600th Janma kalyanak of Bhagwan Mahavir,. The event was attended by over 15,000 Citizens.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 90,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '* Seniors group started in 2007. Allowing seniors to gather in a common community place to socialize, discuss issues and provide resources to help.\n * Youth clubs started in 1998. Events such as team sports, Ski camps, Ahimsa Camps commence annual in the aim of providing youths a safe place to gather and play.',
                                style: TextStyle(
                                  fontFamily: 'Electrolize',
                                  fontSize: screenSize.width / 90,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                '* Women’s group started in 1995 with the aim of providing a supporting environment and to promote women leadership in the community.\n * New Immigrants networking groups started in 2017 with the aim of providing a ‘Helping Hand” to new immigrants into the city.',
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
