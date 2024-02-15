import 'package:dog_api/core/widgets/bottomNav/bottom_nav_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Material(
      color: const Color(0xffD1D1D6),
      child: Padding(
        padding: EdgeInsets.only(bottom: viewPadding.bottom),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final item in NavItem.values) //
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
          colorFilter: (item != selected) //
              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
