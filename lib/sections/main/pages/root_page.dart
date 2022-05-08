import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ihliv/sections/main/controllers/root_controller.dart';
import 'package:ihliv/sections/main/widgets/bottom_bar_item.dart';
import 'package:ihliv/sections/main/widgets/empty_widget.dart';

class RootPage extends StatelessWidget {
  final controller = Get.put(RootController());

  RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(builder: (controller) {
      if (controller.items.isEmpty) return const Scaffold(body: EmptyWidget());

      return Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: BottomBar(
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            currentIndex: controller.index,
            onTap: controller.onSelected,
            items: controller.items.map((e) {
              return BottomBarItem(
                icon: Image.asset(e.iconName),
                activeIcon: Image.asset(e.activeIconName),
                badge: e.badge,
              );
            }).toList(),
          ),
        ),
        body: IndexedStack(
          index: controller.index,
          children: controller.items.map((e) => e.widget).toList(),
        ),
      );
    });
  }
}
