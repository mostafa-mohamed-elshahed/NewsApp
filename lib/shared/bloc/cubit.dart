import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/health_screen/health_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/modules/sport_screen/sport_screen.dart';
import 'package:news_app/modules/technology/technology.dart';
import 'package:news_app/shared/bloc/cubit_state.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsAppCubit extends Cubit<NewsAppCubitState>{
  NewsAppCubit() : super(InitialAppState());
 static NewsAppCubit get(context)=>BlocProvider.of(context);

int currentIndex= 0;

List<Widget> screens=[
  TechnologyScreen(),
  SportScreen(),
  HealthScreen(),

];
List<String> titles=[
  "Technology News",
  "Sports News",
  "Health News",
];

void changeCurrentIndex(int index){
    currentIndex=index;
    emit(ChangeCurrentAppState());
}

  List<dynamic> technology=[];
  List<dynamic> sports=[];
  List<dynamic> health=[];
  List<dynamic> search=[];
  void getSearch(String value){
    DioHelper.getData(url: "v2/everything",
        query: {
      "q":"$value",
      "apiKey":"c35414b64d6c48f78467d988de0fee78",
    }).then((value) => {
      search=value.data["articles"],
      emit(GetSearchDataSuccessDate())

    }).catchError((onError) {
      print("The Error Is search${onError.toString()}");
      emit(GetSearchDataErrorDate());

    });
  }
void technologyData(){
  emit(GetTechnologyDataLoadingDate());
  DioHelper.getData(url: "v2/top-headlines", query: {
    "country":"eg",
    "category":"technology",
    "apiKey":"c35414b64d6c48f78467d988de0fee78",
  }).then((value) => {
    technology=value.data["articles"],
    print(technology[0]["title"]),
    emit(GetTechnologyDataSuccessDate())

  }).catchError((onError) {
    print("The Error Is Technology${onError.toString()}");
    emit(GetTechnologyDataErrorDate());

  });
}


  void healthData(){
    emit(GetHealthDataLoadingDate());

    DioHelper.getData(url: "v2/top-headlines", query: {
      "country":"eg",
      "category":"health",
      "apiKey":"c35414b64d6c48f78467d988de0fee78",
    }).then((value) => {
      health=value.data["articles"],
      print(health[0]["title"]),

      emit(GetHealthDataSuccessDate())

    }).catchError((onError) {
      print("The Error Is Health${onError.toString()}");
      emit(GetHealthDataErrorDate());

    });
  }
  void sportsData(){
    emit(GetSportDataLoadingDate());

    DioHelper.getData(url: "/v2/top-headlines", query: {
      "country":"eg",
      "category":"sports",
      "apiKey":"c35414b64d6c48f78467d988de0fee78",
    }).then((value) => {
      print(value.data["articles"][0]["title"]),
      sports=value.data["articles"],
    emit(GetSportDataSuccessDate())

    }).catchError((onError) {print("The Error Is Sport${onError.toString()}");
    emit(GetSportDataErrorDate());
    });
  }
bool isDark=false;
 void changeTheme({bool? mode}){
   if(mode != null) {
     isDark=mode;
     emit(GetIsDarkDate());
   } else
  isDark=!isDark;
   CacheHelper.putBoolean(key:"isDark", value: isDark).then((value) => emit(GetIsDarkDate()));
}


}