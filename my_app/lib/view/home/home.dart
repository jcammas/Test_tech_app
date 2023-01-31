import 'package:flutter/material.dart';
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

  // Color(0XFF636e72)

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;

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
          title: Row(
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
          ),
          elevation: 0.0,
        ),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: index == 0
              ? const MyList()
              : const SizedBox(
                  child:
                      Text("Favoris !", style: TextStyle(color: Colors.white)),
                ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          onTap: switchIndex,
        ),
      ),
    );
  }
}
