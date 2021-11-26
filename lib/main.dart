import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapps/cubit/cubit.dart';
import 'package:newsapps/cubit/states.dart';
import 'package:newsapps/network/local/cache_helper.dart';
import 'package:newsapps/network/remote/dio_helper.dart';
import 'package:newsapps/news_layout.dart';

import 'on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

   bool?  isDark=CacheHelper.getBoolean(key: 'isDark');


  runApp( MyApp(isDark!));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..changeNewsMode(
          fromShared: isDark
      )..getBusiness()..getScience()..getSport(),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch:Colors.red,
                primaryColor: HexColor('89241f'),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme:  AppBarTheme(
                 backgroundColor: HexColor('89241f'),
                  titleSpacing: 20.0,
                    iconTheme: IconThemeData(color: Colors.white),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('89241f'),
                      statusBarBrightness: Brightness.light,
                    ),
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: HexColor('89241f'),
                  elevation: 20.0,
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                )

            ),
            darkTheme: ThemeData(
                primarySwatch:Colors.deepOrange,
                primaryColor: HexColor('89241f'),
                scaffoldBackgroundColor: HexColor('333739'),
                appBarTheme:  AppBarTheme(
                  titleSpacing: 20.0,
                    iconTheme: IconThemeData(color: Colors.white),
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:HexColor('333739'),
                      statusBarBrightness: Brightness.light,
                    ),
                    backgroundColor: Colors.black54,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: HexColor('89241f'),
                  elevation: 20.0,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey,
                ),
                textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
            ),
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: OnBoarding(),
          );
        },
      ),
    );
  }
}

