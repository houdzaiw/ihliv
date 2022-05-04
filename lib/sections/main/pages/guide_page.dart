import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihliv/base/app_routers.dart';
import 'package:ihliv/base/custom_style.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class GuidePage extends StatefulWidget {
  GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  List items = [
    'assets/base/guide_first.png',
    'assets/base/guide_second.png',
    'assets/base/guide_third.png',
    'assets/base/guide_fourth.png',
  ];

  ValueNotifier<int> currentPageNotifier = ValueNotifier(0);
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: PageView.builder(
                physics: const PageScrollPhysics(),
                controller: pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index) {
                  setState(() {
                    currentPageNotifier.value = index % items.length;
                  });
                },
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final asset = items[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Image.asset(asset, fit: BoxFit.cover),
                  );
                },
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              child: Builder(builder: (context) {
                if (currentPageNotifier.value == items.length - 1) {
                  return ElevatedButton(
                    child: const Text('Start'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.themeBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(46.0 / 2)),
                    ),
                    onPressed: () => Get.offAndToNamed(AppPages.oauth),
                  );
                }
                return CirclePageIndicator(
                  itemCount: items.length,
                  currentPageNotifier: currentPageNotifier,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
