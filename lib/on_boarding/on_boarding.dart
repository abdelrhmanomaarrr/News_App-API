import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapps/component/components.dart';
import 'package:newsapps/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../news_layout.dart';

class BoardingModel
{
   final String image;
   final String tittle;
  final String text;
  BoardingModel(
  {
   required this.image,
   required this.tittle,
   required this.text,
  });
}

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController=PageController();


  List<BoardingModel> boarding=
  [
    BoardingModel(
        image: 'assets/images/News1.jpg',
        tittle: 'Screen1 Title',
        text: 'Screen1 body'),
    BoardingModel(
        image: 'assets/images/News2.jpg',
        tittle: 'Screen2 Title',
        text: 'Screen2 body'),
    BoardingModel(
        image: 'assets/images/News3.jpg',
        tittle: 'Screen3 Title',
        text: 'Screen3 body'),
  ];
  bool ? isLast=false;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: false,).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, NewsLayout(),);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
              onPageChanged: (int index){
                  if(index==boarding.length-1)
                  {
                    setState(() {
                      isLast=true;
                    });
                    print('last');
                  }
                  else {
                      setState(() {
                        isLast=false;
                      });
                    }
              },
              itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children:  [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: HexColor('89241f'),
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length),
               const Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                     if(isLast==true){
                       submit();

                    }else{
                      boardController.nextPage(
                          duration: Duration(
                              milliseconds: 750
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child:const Icon(Icons.arrow_forward_ios) ,
                backgroundColor: HexColor('89241f'),
                )
              ],
            ),
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
     [
      Expanded(
        child: Image(image: AssetImage(model.image)),
      ),
      SizedBox(
        height: 60.0,
      ),
      Text(model.tittle,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),),
      SizedBox(
        height: 15.0,
      ),
      Text(model.text,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),),
    ],
  );
}
