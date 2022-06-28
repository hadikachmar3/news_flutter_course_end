//Packages
import 'package:flutter/material.dart';
import 'package:news_app_flutter_course/inner_screens/blog_details.dart';
import 'package:news_app_flutter_course/providers/news_provider.dart';
import 'package:provider/provider.dart';

//Screens
import 'providers/bookmarks_provider.dart';
import 'screens/home_screen.dart';

//Consts
import 'consts/theme_data.dart';

//Providers
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Need it to access the theme Provider
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  //Fetch the current theme
  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          //Notify about theme changes
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookmarksProvider(),
        ),
      ],
      child:
          //Notify about theme changes
          Consumer<ThemeProvider>(builder: (context, themeChangeProvider, ch) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App - Flutter&API Course',
          theme: Styles.themeData(themeChangeProvider.getDarkTheme, context),
          home: const HomeScreen(),
          routes: {
            NewsDetailsScreen.routeName: (ctx) => const NewsDetailsScreen(),
          },
        );
      }),
    );
  }
}
