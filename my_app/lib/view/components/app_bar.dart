import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: const TextStyle(color: Colors.white),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {},
              )),
        )),
      ],
    );
  }
}
