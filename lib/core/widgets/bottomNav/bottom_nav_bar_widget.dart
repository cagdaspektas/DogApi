import 'package:dog_api/core/widgets/bottomNav/bottom_nav_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../common.dart';

@immutable
class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.onNavItemPressed,
    required this.selected,
  });

  final ValueChanged<NavItem> onNavItemPressed;
  final NavItem selected;

  @override
  Widget build(BuildContext context) {
    final viewPadding = MediaQuery.viewPaddingOf(context);
    return CustomPaint(
      painter: TrapezoidCustomPainter(),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(bottom: viewPadding.bottom),
          child: SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final item in NavItem.values)
                  Expanded(
                    child: BottomNavButton(
                      onPressed: onNavItemPressed,
                      item: item,
                      selected: selected,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    super.key,
    required this.onPressed,
    required this.item,
    required this.selected,
  });

  final ValueChanged<NavItem> onPressed;
  final NavItem item;
  final NavItem selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(item),
      child: Padding(
        padding: verticalPadding12 + bottomPadding4,
        child: SvgPicture.asset(
          item.navIconAsset,
          colorFilter: (item != selected) ? const ColorFilter.mode(Colors.black, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}

class TrapezoidCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xffF2F2F7)
      ..style = PaintingStyle.fill;

    double inset = 40.0;

    Path path = Path()
      ..moveTo(inset, 0)
      ..lineTo(size.width - inset, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
