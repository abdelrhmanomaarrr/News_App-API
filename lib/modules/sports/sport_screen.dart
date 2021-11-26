
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapps/component/components.dart';
import 'package:newsapps/cubit/cubit.dart';
import 'package:newsapps/cubit/states.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener:(context,state) {},
      builder:(context,state) {
        var list= NewsCubit.get(context).sport;
        return articleBuilder(list,context);
      },
    );
  }
}
