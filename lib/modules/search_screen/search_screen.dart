import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/cubit_state.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
final TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var list=NewsAppCubit.get(context);
    return BlocConsumer<NewsAppCubit,NewsAppCubitState>(
      listener: (context,state){},builder:(context,state)=> Scaffold
      (
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defaultTextFromField(prefix: null,
                textEditingController: controller,
                textInputType: TextInputType.name,
                validate: (String value){
                  if(value.isEmpty){
                    return "value is empty";
                  }else{
                    return null;
                  }
                },
                label: "search",
                suffix: Icons.search,
              onTap: (){

              },
              onChange: (value)=>NewsAppCubit.get(context).getSearch(value),
            ),
          ),
          Expanded(child: listItemView(nameList:list.search)),
        ],
      ),
    ),
    );
  }
}
