import 'package:flutter/material.dart';

class Screen {
  String imagePath = "";
  String headingText = "";
  String subText = "";

  Screen({this.imagePath, this.headingText, this.subText});
}

enum PageIndicatorType { circle, rectangle }

class OnBoardingScreen extends StatefulWidget {
  //init
  List<Screen> screenList;
  TextStyle headingTextStyle;
  TextStyle subTextStyle;
  Size pageIndicatorSize;
  PageIndicatorType pageIndicatorType;
  Color pageIndicatorColor;
  bool showSkipButton;
  Widget skipButton;
  Widget nextButton;
  Widget doneButton;
  Function onSkip;
  Function onDone;

  //constructure
  OnBoardingScreen(
      {@required this.screenList,
      @required this.headingTextStyle,
      @required this.subTextStyle,
      this.pageIndicatorSize = const Size(20, 8),
      this.pageIndicatorType = PageIndicatorType.circle,
      this.pageIndicatorColor,
      this.showSkipButton = true,
      this.skipButton,
      this.onSkip,
      this.nextButton,
      this.doneButton,
      this.onDone});
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //init
  PageController pageController = PageController();
  int pageIndex = 0;

  //
  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        pageIndex = pageController.page.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: (pageIndex != widget.screenList.length - 1)
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    (widget.showSkipButton && widget.skipButton != null)
                        ? FloatingActionButton(
                            highlightElevation: 0,
                            onPressed: widget.onSkip,
                            child: widget.skipButton,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.grey[500],
                          )
                        : Text(""),
                    FloatingActionButton(
                      highlightElevation: 0,
                      onPressed: () {
                        pageController.nextPage(
                            duration: Duration(
                              milliseconds: 500,
                            ),
                            curve: Curves.easeInOut);
                      },
                      child: widget.nextButton,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: widget.headingTextStyle.color,
                    )
                  ],
                ),
              )
            : FloatingActionButton(
                onPressed: widget.onDone,
                child: widget.doneButton,
                isExtended: true,
                backgroundColor: widget.headingTextStyle.color,
                shape: RoundedRectangleBorder(),
              ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView.builder(
            pageSnapping: true,
            controller: pageController,
            itemCount: widget.screenList.length,
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //image
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 25),
                      child: Image.asset(
                        '${widget.screenList[index].imagePath}',
                        width: MediaQuery.of(context).size.width * 0.7,
                      ),
                    ),
                    //heading text
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Center(
                        child: Text(
                          "${widget.screenList[index].headingText}",
                          style: widget.headingTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    //sub text
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 25),
                      child: Center(
                        child: Text(
                          "${widget.screenList[index].subText}",
                          style: widget.subTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.screenList.length,
                (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    width: (pageIndex == index.toInt())
                        ? widget.pageIndicatorSize.width
                        : widget.pageIndicatorSize.height,
                    height: widget.pageIndicatorSize.height,
                    margin: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: (pageIndex == index.toInt())
                          ? (widget.pageIndicatorColor == null)
                              ? widget.headingTextStyle.color
                              : widget.pageIndicatorColor
                          : (widget.pageIndicatorColor == null)
                              ? widget.headingTextStyle.color.withOpacity(0.4)
                              : widget.pageIndicatorColor.withOpacity(0.4),
                      shape: BoxShape.rectangle,
                      borderRadius:
                          (widget.pageIndicatorType == PageIndicatorType.circle)
                              ? BorderRadius.circular(100)
                              : BorderRadius.circular(0),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

