import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapps/modules/webview/web_view_screen.dart';

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(
      article['url']
    ));
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          height: 120,
  
          width: 120,
  
          decoration:  BoxDecoration(
  
              borderRadius: BorderRadius.circular(10.0),
  
              image: DecorationImage(
  
                image: NetworkImage('${article['urlToImage']}'),
  
                fit: BoxFit.cover,
  
              )
  
          ),
  
        ),
  
        SizedBox(width: 20,),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              children:  [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyText1,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,),
  
                ),
  
                Text('${article['publishedAt']}',
  
                  style: TextStyle(
  
                    color: Colors.grey,
  
                  ),),
  
              ],
  
            ),
  
          ),
  
        )
  
  
  
      ],
  
    ),
  
  ),
);

Widget articleBuilder(list,context,{isSearch=true})=>ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index) => buildArticleItem(list[index],context) ,
      separatorBuilder: (context,index)=>myDriver(),
      itemCount: 10),
  fallback: (context)=> isSearch ? Container() : Center(child: CircularProgressIndicator()),
);

  Widget myDriver()=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function ?onChange,
  Function ?onTap,
  bool isPassword = false,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData ?suffix,
  Function ?suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: (s){
        onSubmit!(s);
      },
      onChanged: (s){
        onChange!(s);
      },
      onTap: (){
        onTap!();
      },
      validator: (s){
        validate(s);
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: (){
            suffixPressed!();
          },
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context,widget)=> Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) =>  widget,
    ),
        (route) => false
);
Widget defaultTextButton({
  required Function function,
  required String text,
})=>TextButton(
  onPressed :()=> function(),
  child:Text(
      text.toUpperCase()),);