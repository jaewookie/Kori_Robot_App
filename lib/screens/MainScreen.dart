import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kori_proto/screens/AdminScreen.dart';
import 'package:kori_proto/screens/ConfigScreen.dart';
import 'package:kori_proto/screens/LinkConnectorScreen.dart';
import 'package:kori_proto/screens/ServiceScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DateTime? currentBackPressTime;
  String _text = "뒤로가기 버튼을 한 번 더 누르시면 앱이 종료됩니다.";

  FToast? fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) >
                const Duration(milliseconds: 1300)) {
          currentBackPressTime = now;
          fToast?.showToast(
              toastDuration: Duration(milliseconds: 1300),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ImageIcon(
                          AssetImage('assets/logos/ExaIcon.png'),
                          size: 30,
                          color: Color(0xffB7B7B7),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          _text,
                          style: Theme.of(context).textTheme.headlineLarge,
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    )
                  ],
                ),
              ),
              gravity: ToastGravity.BOTTOM);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: screenHeight*0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth*0.85,
                height: screenHeight*0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ServiceScreen();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.075,
                            ),
                            ImageIcon(
                              AssetImage('assets/logos/ExaIcon.png'),
                              size: 150,
                              color: Color(0xffB7B7B7),
                            ),
                            SizedBox(
                              width: screenWidth * 0.055,
                            ),
                            Text(
                              '서비스 시작',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF2D2D2D),
                          fixedSize: Size(screenWidth * 0.85, screenHeight * 0.15),
                          shape: RoundedRectangleBorder(side: BorderSide(
                            color: Color(0xFFB7B7B7),
                            style: BorderStyle.solid,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(80))
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return LinkConnectorScreen();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.075,
                            ),
                            Icon(Icons.link, color: Color(0xffB7B7B7),size: 150,),
                            SizedBox(
                              width: screenWidth * 0.055,
                            ),
                            Text(
                              '커넥터 연결',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF2D2D2D),
                            fixedSize: Size(screenWidth * 0.85, screenHeight * 0.15),
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Color(0xFFB7B7B7),
                                style: BorderStyle.solid,
                                width: 2
                            ),
                                borderRadius: BorderRadius.circular(80))
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AdminScreen();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.075,
                            ),
                            Icon(Icons.admin_panel_settings, size: 150, color: Color(0xffB7B7B7),),
                            SizedBox(
                              width: screenWidth * 0.055,
                            ),
                            Text(
                              '관리자 메뉴',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF2D2D2D),
                            fixedSize: Size(screenWidth * 0.85, screenHeight * 0.15),
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Color(0xFFB7B7B7),
                                style: BorderStyle.solid,
                                width: 2
                            ),
                                borderRadius: BorderRadius.circular(80))
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ConfigScreen();
                          }));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.075,
                            ),
                            Icon(Icons.settings, size: 150, color: Color(0xffB7B7B7),),
                            SizedBox(
                              width: screenWidth * 0.055,
                            ),
                            Text(
                              '설정',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF2D2D2D),
                            fixedSize: Size(screenWidth * 0.85, screenHeight * 0.15),
                            shape: RoundedRectangleBorder(side: BorderSide(
                                color: Color(0xFFB7B7B7),
                                style: BorderStyle.solid,
                                width: 2
                            ),
                                borderRadius: BorderRadius.circular(80))
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
