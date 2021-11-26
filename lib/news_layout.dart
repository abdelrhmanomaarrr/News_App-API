import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapps/component/components.dart';
import 'package:newsapps/cubit/cubit.dart';
import 'package:newsapps/cubit/states.dart';
import 'package:newsapps/modules/Search/search_screen.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit= NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('NewsApp'),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),bottomRight: Radius.circular(80))
              ),
              actions: [
                IconButton(onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                    icon: Icon(Icons.search)),
                IconButton(onPressed: (){
                  NewsCubit.get(context).changeNewsMode();
                },
                    icon: Icon(Icons.brightness_4_outlined),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:  cubit.currentIndex,
                onTap: (index){
                cubit.ChangeBottomNavBar(index);
                },
                items: cubit.bottomItems),
          );
        },
        );
  }
}
