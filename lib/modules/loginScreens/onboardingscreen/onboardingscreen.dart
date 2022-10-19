// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop/modules/loginScreens/onboardingscreen/start.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel {
  final String image;
  final String tittle1;
  final String tittle2;
  OnBoardingModel(
      {required this.image, required this.tittle1, required this.tittle2});
}

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageViewController = PageController(initialPage: 0);
    List<OnBoardingModel> boarding = [
      OnBoardingModel(
          image: 'assets/images/Online shopping-pana.svg',
          tittle1: "استكشاف المنتجات",
          tittle2: "اكتشف العديد من المنتجات وقم بالتسوق الأن"),
      OnBoardingModel(
          image: "assets/images/Credit card-bro.svg",
          tittle1: "قم بالدفع",
          tittle2: "لديك العديد من الخيارات الخاصة بالدفع"),
      OnBoardingModel(
          image: 'assets/images/Successful purchase.svg',
          tittle1: "استمتع بالتسوق",
          tittle2: "أحصل على منتجات عالية الجودة وبأسعار معقولة"),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: boarding.length,
                controller: pageViewController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) =>
                    buildBoardingItem(boarding[index]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageViewController,
                    count: boarding.length,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) {
                      pageViewController.animateToPage(
                        i,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      spacing: 8,
                      radius: 16,
                      dotWidth: 16,
                      dotHeight: 16,
                      dotColor: Color(0xFF9E9E9E),
                      activeDotColor: defaultcolor,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      navigateAndFinish(context, StartPage());
                    },
                    child: Text(
                      "تخطى",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: HexColor("#F99100"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(OnBoardingModel model) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(
            model.image,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          model.tittle1,
          style: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
            color: HexColor("#1E55A2"),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          model.tittle2,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.normal,
            color: HexColor("#313131"),
          ),
        ),
      ],
    ),
  );
}