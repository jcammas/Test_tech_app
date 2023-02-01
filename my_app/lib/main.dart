import 'package:flutter/material.dart';
import 'package:my_app/provider/provider_images.dart';
import 'package:my_app/view/home/home.dart';
import 'package:my_app/view/home/widget/full_screen.dart';
import 'package:my_app/view/searchScreen/search_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImgProvider imageProvider = ImgProvider();

    return ChangeNotifierProvider(
      create: (_) => imageProvider,
      child: MultiProvider(
        providers: [ChangeNotifierProvider.value(value: imageProvider)],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: "/",
          routes: {
            '/': (_) => const Home(),
            '/searchScreenResults': (_) => const SearchScreenResults(),
            '/fullScreen': (_) => const FullScreen(),
          },
          // onUnknownRoute: (_) => MaterialPageRoute(
          //   builder: (_) => const NotFound(),
          // ),
        ),
      ),
    );
  }
}
