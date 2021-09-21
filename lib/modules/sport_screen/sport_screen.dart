import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/cubit_state.dart';
import 'package:news_app/shared/components/components.dart';

class SportScreen extends StatelessWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsAppCubit, NewsAppCubitState>(
        builder: (context, state) {
          NewsAppCubit cubit =NewsAppCubit.get(context);
          return listItemView(nameList: cubit.sports);
        },
        listener: (context, state) {});
  }
}
