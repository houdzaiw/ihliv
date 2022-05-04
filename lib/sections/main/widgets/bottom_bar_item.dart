import 'dart:ui';

import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  Color? color;
  int? badge;
  double? fontSize;

  BadgeWidget(this.badge, {Key? key, this.color, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (badge == null || badge == 0) {
      return Container();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints(minWidth: 12, minHeight: 12),
      child: Text(
        badge.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  Widget? child;

  BottomBar({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 200.0),
        child: Opacity(opacity: 1, child: child),
      ),
    );
  }
}

class BottomBarItem extends BottomNavigationBarItem {
  BottomBarItem({required Widget icon, Widget? activeIcon, int? badge})
      : super(
          label: '',
          icon: Stack(
            children: [
              icon,
              Positioned(right: 0, child: BadgeWidget(badge)),
            ],
          ),
          activeIcon: Stack(
            children: [
              ClipRRect(
                child: activeIcon,
                borderRadius: BorderRadius.circular(20.0),
              ),
              Positioned(right: 0, child: BadgeWidget(badge)),
            ],
          ),
        );
}
