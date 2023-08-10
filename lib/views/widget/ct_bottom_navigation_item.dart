import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:flutter/material.dart';

class CTBottomNavigation extends StatelessWidget {
  final ValueChanged<int> onTap;
  final List<CTBottomNavigationItem> items;

  const CTBottomNavigation({
    super.key,
    required this.onTap,
    required this.items,
  })  : assert(items.length >= 2),
        assert(items.length <= 6);

  @override
  Widget build(BuildContext context) {
    List<Widget> getWidgetNavigationItem() {
      final List<Widget> listItem = [];
      int? middleIndex;

      for (var i = 0; i < items.length; i++) {
        listItem.add(_BottomNavigationTile(
          ctBottomNavigationItem: items[i],
          onTap: () => onTap.call(i),
        ));
      }

      if (items.length.isEven) {
        middleIndex = (items.length / 2).round(); // Calculate the middle index

        listItem.insert(middleIndex, const SizedBox());
      }

      return listItem;
    }

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(30),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        clipBehavior: Clip.antiAlias,
        height: 80,
        color: backgroundColor4,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: getWidgetNavigationItem(),
        ),
      ),
    );
  }
}

class _BottomNavigationTile extends StatelessWidget {
  final VoidCallback onTap;
  final CTBottomNavigationItem ctBottomNavigationItem;

  const _BottomNavigationTile(
      {required this.onTap, required this.ctBottomNavigationItem});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: ctBottomNavigationItem,
    );
  }
}

class CTBottomNavigationItem extends StatelessWidget {
  final Widget icon;
  const CTBottomNavigationItem({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: icon,
    );
  }
}
