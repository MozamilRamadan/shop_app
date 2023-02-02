import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../shared/components/components.dart';
import '../shared/network/local/cache_helper.dart';
import 'login/shop_login_screen.dart';
class BoardingModel{
  final String title;
  final String body;
  final String image;
  BoardingModel({
    required this.title,
    required this.body,
    required this.image,
});
}
var boardingController = PageController();
bool isLast = false;

class OnBoarding_Screen extends StatefulWidget {
  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  //const OnBoarding_Screen({Key? key}) : super(key: key);
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Screen Title 1',
        body: 'Screen Body 1',
        image: 'assets/images/setting.png'),
    BoardingModel(
        title: 'Screen Title 2',
        body: 'Screen Body 2',
        image: 'assets/images/setting.png'),
    BoardingModel(
        title: 'Screen Title 3',
        body: 'Screen Body 3',
        image: 'assets/images/setting.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          TextButton(onPressed: submit, child: const Text('SKIP',
         ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1){
                    setState(() {
                      isLast = true;
                    });
                  }else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder:(context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect: ExpandingDotsEffect(
                      dotColor:Colors.grey ,
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Colors.orangeAccent,
                      spacing: 5,
                      expansionFactor: 4,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(isLast){
                    submit();
                  }else{
                    boardingController.nextPage(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn);}

                },
                child: Icon(Icons.arrow_right_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  Widget buildBoardingItem(BoardingModel model) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  // Image(image: AssetImage('assets/images/onboarding-1.jpg')),
  Expanded(
  child: Center(
    child: Container(
    width: 600,
    height: 300,
    child: Image.asset('${model.image}')),
  ),
  ),
  SizedBox(height: 20,),
  Text('${model.title}',
  style: TextStyle(
  fontSize: 20,
  ),
  ),
  SizedBox(height: 20,),
  Text('${model.body}',
  style: TextStyle(
  fontSize: 14,
  ),),
  ],
  );

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value) {
        navigatorAndEnd(context, ShopLoginScreen());
        print("The value is : $value");
      }

    });
  }
}
