import 'package:flutter/material.dart';
import 'package:my_app/view/home/widget/images_list.dart';
import 'package:my_app/view/searchScreen/search_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

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

  navigate(String searchController) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SearchScreenResults(
          query: searchController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Flexible(
      child: Column(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search for Images...",
                      hintStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (searchController.text.isEmpty) {
                          } else {
                            navigate(searchController.text);
                            searchController.clear();
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                    onSubmitted: (value) async {
                      if (searchController.text.isEmpty) {
                      } else {
                        navigate(searchController.text);
                        searchController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const ImagesList(),
        ],
      ),
    );
  }
}
