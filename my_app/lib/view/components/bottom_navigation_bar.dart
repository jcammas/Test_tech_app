import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final void Function(int)? onPressed;

  const MyBottomBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 35,
            color: Colors.white,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            size: 35,
            color: Colors.white,
          ),
          label: '',
        )
      ],
      onTap: onPressed,
    );
  }
}
