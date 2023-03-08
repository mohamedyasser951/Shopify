import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/modules/login_screen/login_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/local/sheredpref_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String title;
  final String body;
  final String image;
  BoardingModel({required this.title, required this.body, required this.image});
}

class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool isLast = false;
  // bool isonBoarding = true;

  void submiStateOfOnboarding() async {
    await SharedHelper.saveData(key: "onBoarding", value: true).then((value) {
      if (value) {
        navigatePushAndReplacement(context: context, widget: LoginScreen());
      }
    });
  }

  List<BoardingModel> boaring = [
    BoardingModel(
        title: "Explore",
        body:
            "Choose Whatever the Product you wish for with easiest Way possible using ShopMarket ",
        image: "assets/images/onboarding_image1.jpg"),
    BoardingModel(
        title: "Shiping",
        body:
            "Your Order will be Shipped to you as fast as possible by our Carrier",
        image: "assets/images/onboarding_image10.jpg"),
    BoardingModel(
        title: "Screen title3",
        body: "screen title3",
        image: "assets/images/onboarding_image0.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submiStateOfOnboarding();
              },
              child: const Text("Skip"))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                    onPageChanged: ((value) {
                      if (value == boaring.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    }),
                    physics: BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: 3,
                    itemBuilder: ((context, index) =>
                        buildOnBoardingItem(boaring[index])))),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boaring.length,
                  effect: const ExpandingDotsEffect(
                      dotColor: Colors.purple,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      expansionFactor: 4.0,
                      spacing: 5.0),
                ),
                Spacer(),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                  onPressed: () {
                    if (isLast) {
                      submiStateOfOnboarding();
                    } else {
                      pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              height: 120.0,
              image: AssetImage("${model.image}"),
            ),
          ),
          Text(
            "${model.title}",
            style: const TextStyle(fontSize: 24.0),
          ),
          Text(
            "${model.body}",
            style: const TextStyle(fontSize: 14.0),
          ),
        ],
      );
}
