import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/cubit_state.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

main()async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool? isDark = CacheHelper.getBoolean(key:"isDark");

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => NewsAppCubit()..changeTheme(mode: isDark)
      ..technologyData()
      ..healthData()
      ..sportsData(),
    child: BlocConsumer<NewsAppCubit, NewsAppCubitState>(
    listener: (BuildContext context, state) {},
    builder: (BuildContext context, Object? state) {
    NewsAppCubit cubit = NewsAppCubit.get(context);
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(bodyText1: TextStyle(color:Colors.black,fontWeight: FontWeight.w900,fontSize: 18 ) ),
          scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w900),
          backwardsCompatibility: false,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 20,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.black
        )
      ),
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          textTheme: TextTheme(bodyText1: TextStyle(color:Colors.white,fontWeight: FontWeight.w900,fontSize: 18 ) ),

          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            elevation: 0,
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w900),
            backwardsCompatibility: false,
            centerTitle: true,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              elevation: 20,
              backgroundColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey
          )
      ),
      themeMode:cubit.isDark?ThemeMode.dark:ThemeMode.light  ,
      debugShowCheckedModeBanner: false,
      home: HomeLayoutScreen()
    );
    }));
  }
}

