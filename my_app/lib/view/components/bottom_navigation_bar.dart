import 'package:flutter/material.dart';

class MyBottomBar extends StatelessWidget {
  final void Function(int)? onPressed;
  final int i;

  const MyBottomBar({super.key, required this.onPressed, required this.i});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: i == 0
                ? const Icon(
                    Icons.home,
                    size: 35,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.home,
                    size: 35,
                    color: Colors.white54,
                  ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: i == 1
                ? const Icon(
                    Icons.favorite,
                    size: 35,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.favorite,
                    size: 35,
                    color: Colors.white54,
                  ),
            label: '',
          )
        ],
        onTap: onPressed,
      ),
    );
  }
}
