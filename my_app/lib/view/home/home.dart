import 'package:flutter/material.dart';
import 'package:my_app/view/components/app_bar.dart';
import 'package:my_app/view/components/bottom_navigation_bar.dart';
import 'package:my_app/view/home/widget/images_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  int index = 0;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void switchIndex(newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey, Colors.grey])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0.0,
              title: const MyAppBar()),
          body: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: index == 0
                ? const MyList()
                : const SizedBox(
                    child: Text("Favoris !",
                        style: TextStyle(color: Colors.white)),
                  ),
          ),
          bottomNavigationBar: MyBottomBar(onPressed: switchIndex)),
    );
  }
}
