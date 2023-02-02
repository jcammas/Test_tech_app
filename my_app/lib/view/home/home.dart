import 'package:flutter/material.dart';
import 'package:my_app/view/components/app_bar.dart';
import 'package:my_app/view/components/bottom_navigation_bar.dart';
import 'package:my_app/view/favoris/favoris.dart';
import 'package:my_app/view/searchScreen/widgets/search_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String routeName = "/";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey, Colors.black87])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              toolbarHeight: screenHeight * 0.07,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0.0,
              title: const MyAppBar()),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Column(
              children: [
                index == 0 ? const SearchScreen() : const FavorisList(),
              ],
            ),
          ),
          bottomNavigationBar: MyBottomBar(onPressed: switchIndex, i: index)),
    );
  }
}
