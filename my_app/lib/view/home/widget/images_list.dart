import 'package:flutter/material.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ListView(
      padding: const EdgeInsets.all(10),
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: Colors.grey,
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color.fromARGB(255, 208, 208, 208), width: 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Image.network(
                          "https://images.unsplash.com/photo-1590507014612-08b6a0b4e31e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=736&q=80",
                          fit: BoxFit.fill)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.favorite_border,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.download,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.share,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
