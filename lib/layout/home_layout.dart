import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search_screen/search_screen.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/cubit_state.dart';

class HomeLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppCubitState>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            NewsAppCubit cubit = NewsAppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(cubit.titles[cubit.currentIndex],),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                    },
                    icon: Icon(Icons.search),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.changeTheme();
                    },
                    icon: Icon(Icons.brightness_4_sharp),
                  ),
                ],
              ),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                  elevation: 0,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                  iconSize: 25,
                  onTap: (index) {
                    cubit.changeCurrentIndex(index);
                  },
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.sports_baseball_rounded),
                      label: "Technology News",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.health_and_safety),
                      label: "Sports News",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.laptop),
                      label: "Health News",
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.settings),
                    //   label: "Settings",
                    // ),
                  ]),
            );
          });
  }
}
