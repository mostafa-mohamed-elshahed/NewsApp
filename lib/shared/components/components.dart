
import 'package:flutter/material.dart';

Widget listItemView({required nameList,})=> ListView.separated
  (
    itemBuilder: (context, index) => InkWell(
      child: Container(height:120,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)),
                  child: Image(
                    image: NetworkImage(nameList[index]["urlToImage"]??"https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGhvdG98ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                    height: 180,
                    width: 160,
                    fit: BoxFit.cover,
                  )
                // child: Text("image"),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Text(
                          nameList[index]["title"],
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText1,
                        )),
                    Text(nameList[index]["publishedAt"],style: TextStyle(fontSize: 16,color: Colors.grey),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    separatorBuilder: (context, index) => SizedBox(
      child: Container(
        color: Colors.black,
      ),
      height: 2,
    ),
    itemCount:nameList.length );





Widget defaultTextFromField({
  @required TextEditingController? textEditingController,
  @required TextInputType? textInputType,
  @required Function? validate,
  @required String? label,
  @required IconData? prefix,
  @required IconData? suffix,
  Function? onTap,
  Function? onSubmit,
  Function? onChange,
  bool isPassword =false,
  bool enabledToOpenKeyboard =true,
}) => TextFormField(
  onTap: (){
    onTap!();
  },
  controller: textEditingController,
  keyboardType: textInputType,
  obscureText: isPassword,
  enabled: enabledToOpenKeyboard,
  onFieldSubmitted: (value){
    onSubmit!(value);
  },
  onChanged: (value){
    onChange!(value);
  },
  validator: (value){
    validate!(value);
  },
  // (String نضع نوع استرنج حتي يتيح لنا اختيار ايز إمتي  value){if(value isEmpty){return ""}return null; }
  decoration: InputDecoration(
   focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
       color: Colors.black,
   ),
  ),
    labelStyle: TextStyle(color: Colors.black),
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix !=null ? Icon(suffix,color: Colors.black,) : null,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(
        color: Colors.black,
       width: 2)),
    enabled: true,
  ),
);