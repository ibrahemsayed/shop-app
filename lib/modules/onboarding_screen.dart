import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:udemy_shop_app/modules/login_module/login_screen.dart';
import 'package:udemy_shop_app/network/local/shared_preferences.dart';
import 'package:udemy_shop_app/shared_components/shared.dart';

class OnboardingScreen extends StatefulWidget {
  //const OnboardingScreen({ Key? key }) : super(key: key);
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var onboardController = PageController();

  var isLast = false;

  List<PageModel> pages = [
    PageModel(
        imageUrl: 'assets/images/onboarding1.jpg',
        pageTitle: 'Shop and Enjoy',
        pageContent: 'Enjoy a pleasant shopping experience full of surprises'),
    PageModel(
        imageUrl: 'assets/images/onboarding2.jpg',
        pageTitle: 'fast and safe delivery',
        pageContent:
            'Order the products you want and you will receive it wherever you are'),
    PageModel(
        imageUrl: 'assets/images/onboarding3.jpg',
        pageTitle: 'suitable for everyone',
        pageContent:
            'Suitable for everyone, you will find everything you are looking for')
  ];

  void submitOnboarding() async {
    await CacheHelper.setData(key: 'onBoarding', value: true)
        .then((value) => navigateAndReplecement(context, LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: submitOnboarding,
            child: Text('Skip'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisSize: MainAxisSize.min,
          children: [
            //buildSingleOnbording(),
            Expanded(
              child: PageView.builder(
                controller: onboardController,
                itemBuilder: (context, index) {
                  return buildSingleOnbording(pages[index]);
                },
                itemCount: pages.length,
                onPageChanged: (int pageNumber) {
                  if (pageNumber == pages.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            //    ******    Indicator and floating button     ******   //
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onboardController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.deepOrange,
                    spacing: 4,
                    strokeWidth: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: isLast
                      ? submitOnboarding
                      : () {
                          onboardController.nextPage(
                              duration: Duration(milliseconds: 750),
                              curve: Curves.fastLinearToSlowEaseIn);
                        },
                  child: Icon(Icons.arrow_forward_ios),
                  backgroundColor: Colors.deepOrange,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildSingleOnbording(PageModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image.asset(
          '${model.imageUrl}',
        )),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${model.pageTitle}',
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text('${model.pageContent}'),
      ],
    );
  }
}

class PageModel {
  final String imageUrl;
  final String pageTitle;
  final String pageContent;
  PageModel({
    required this.imageUrl,
    required this.pageTitle,
    required this.pageContent,
  });
}
