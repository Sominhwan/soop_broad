
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/custom_theme_mode.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.bottom,
    this.backgroundColor,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final double height = preferredSize.height;

    return ValueListenableBuilder<bool>(
      valueListenable: CustomThemeMode.current,
      builder: (context, value, child) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 0),
                child: Row(
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: value ? Colors.black : Colors.white)),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.search, color: value ? Colors.black : Colors.white),
                      onPressed: () {
                        // Search button pressed
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications, color: value ? Colors.black : Colors.white),
                      onPressed: () {
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.change_circle, color: value ? Colors.black : Colors.white),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        CustomThemeMode.change();
                      },
                    ),
                    // PopupMenuButton<String>(
                    //   icon: Icon(Icons.add_circle, color: value ? Colors.black : Colors.white),
                    //   onSelected: (String result) {
                    //     // Menu item selected
                    //   },
                    //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    //     const PopupMenuItem<String>(
                    //       value: 'Item 1',
                    //       child: Text('Item 1'),
                    //     ),
                    //     const PopupMenuItem<String>(
                    //       value: 'Item 2',
                    //       child: Text('Item 2'),
                    //     ),
                    //   ],
                    // ),
                    leading ?? IconButton(
                      icon: Icon(Icons.menu, color: value ? Colors.black : Colors.white),
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                    ),
                  ],
                ),
              ),
              if (bottom != null) bottom!,
            ],
          ),
        );
      }
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
