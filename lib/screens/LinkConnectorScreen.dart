import 'package:flutter/material.dart';

class LinkConnectorScreen extends StatefulWidget {
  const LinkConnectorScreen({Key? key}) : super(key: key);

  @override
  State<LinkConnectorScreen> createState() => _LinkConnectorScreenState();
}

class _LinkConnectorScreenState extends State<LinkConnectorScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            // padding: EdgeInsets.only(right: screenWidth * 0.07),
            padding: EdgeInsets.fromLTRB(0, screenHeight*0.0015, screenWidth*0.05, 0),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.home_outlined,
            ),
            color: Color(0xffB7B7B7),
            iconSize: screenHeight * 0.05,
          )
        ],
        toolbarHeight: screenHeight * 0.08,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('커넥터 연결 페이지', style: Theme.of(context).textTheme.displayMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
