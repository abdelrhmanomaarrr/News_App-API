import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapps/cubit/states.dart';
import 'package:newsapps/modules/business/business_screen.dart';
import 'package:newsapps/modules/science/science_screen.dart';
import 'package:newsapps/modules/sports/sport_screen.dart';
import 'package:newsapps/network/local/cache_helper.dart';
import 'package:newsapps/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex =0;
  List<BottomNavigationBarItem>bottomItems=
  [
    BottomNavigationBarItem(
  icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
  icon: Icon(Icons.sports),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
  icon: Icon(Icons.science),
      label: 'science',
    ),
  ];
  List<Widget>screens=
  [
    BusinessScreen(),
    SportScreen(),
    Science_Screen(),

  ];
  void ChangeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index==1)
      getSport();
    if(index==2)
      getScience();

    emit(NewsBottomNavState());
  }
  List<dynamic > business=[];
  void getBusiness() {
    emit(GetBusinessLoadingState());
    DioHelper().getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': 'e0f4431655a24c79932e4b2967642cd3',
    }).then((value) {
//        print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(GetBusinessSuccessState());
    }).catchError((error) {
      print(error().toString());
      emit(GetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic > sport=[];

  void getSport() {
    emit(GetSportLoadingState());
    if(sport.length==0)
    {
      DioHelper().getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': 'e0f4431655a24c79932e4b2967642cd3',
      }).then((value)
      {
//        print(value.data['articles'][0]['title']);
        sport = value.data['articles'];
        print(sport[0]['title']);
        emit(GetSportSuccessState());
      }).catchError((error) {
        print(error().toString());
        emit(GetSportErrorState(error.toString()));
      });
    }else
      {
        emit(GetSportSuccessState());
      }
  }

  List<dynamic > science=[];
  void getScience() {
    emit(GetScienceLoadingState());
    if(science.length==0)
    {
      DioHelper().getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': 'e0f4431655a24c79932e4b2967642cd3',
      }).then((value) {
//        print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(GetScienceSuccessState());
      }).catchError((error) {
        print(error().toString());
        emit(GetScienceErrorState(error.toString()));
      });
    }else
      {
        emit(GetScienceSuccessState());
      }
  }

  List<dynamic> search = [];

  // هنا معناها ان هدوس علي ال icon  ف هجيب الل sports
  void getSearch(String? value) {
    emit(GetSearchLoadingState());
    // عشان الداتا تيجي مره واحده متحملش مع كل ضغطه علي الل icon  في BNB
    // ولكن هنا بعد ما جبت sports  انا مش هدخل داخل dio لا تساوي ال 0 لان فية داتا يعني هيعمل load مره واحده بسسس
    // الفديو 93 الدقيقه 45
    DioHelper().getData(
        url: 'v2/everything',
        query: {
          'q': '$value',
          'apikey': 'f1dc51a27ad64097a663e717f91ea915',
        }).then((value) {
//        print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(GetSearchSuccessState());
    }).catchError((error) {
      print(error().toString());
      emit(GetSearchErrorState(error.toString()));
    });

  }


  bool isDark=false;
  void changeNewsMode({ bool? fromShared})
  {
    if(fromShared != null) {
      isDark=fromShared;
    } else {
      isDark=!isDark;
    }
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
    {
      emit(NewsChangeMode());
    });

  }

}