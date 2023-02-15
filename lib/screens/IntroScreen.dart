import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kori_proto/screens/MainScreen.dart';

import 'package:video_player/video_player.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AudioPlayer _audioPlayer;

  bool updateComplete = false;

  late final AnimationController _textAniCon = AnimationController(
    duration: const Duration(milliseconds: 1500),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _textAniCon,
    curve: Curves.easeOut,
  );

  DateTime? currentBackPressTime;
  String _text = "뒤로가기 버튼을 한 번 더 누르시면 앱이 종료됩니다.";
  String _audioFile = 'assets/voices/welcome.mp3';

  FToast? fToast;

  @override
  void initState() {
    super.initState();
    // Duration mediaDuration = _controller.value.duration;
    _controller = VideoPlayerController.asset('assets/videos/KoriIntroLongDu.mp4')
      ..initialize().then((_) {
        _controller.setLooping(false);
        // setLooping -> true 무한반복 false 1회 재생
        setState(() {});
      });

    _audioPlayer = AudioPlayer()..setAsset(_audioFile);

    fToast = FToast();
    fToast?.init(context);
    _playVideo();
  }

  void _playVideo() async {
    await Future.delayed(Duration(seconds: 1));
    FlutterNativeSplash.remove();
    _controller.play();
    _updateData();
  }

  void _playAudio(){
    _audioPlayer.setVolume(1);
    _audioPlayer.play();
  }

  // 추후 로딩 시 데이터 업데이트 및 로딩시 사용할 함수 현재는 임의로 2초의 시간 딜레이로 지정

  void _updateData() async {
    Duration mediaDuration = _controller.value.duration;
    Duration introDuration = mediaDuration + Duration(milliseconds: 200);
    await Future.delayed(introDuration);
    _playAudio();
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
      updateComplete = true;
    });
  }

  // 페이지 이동 및 돌아오기 방지를 위한 메소드

  void _navToMain() async {
    Navigator.pushAndRemoveUntil(
        context, scaleIn(MainScreen()), (route) => false);
  }

  Route scaleIn(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, page) {
        var begin = 0.0;
        var end = 1.0;
        var curve = Curves.easeOutSine;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return FadeTransition(
          opacity: animation.drive(tween),
          child: page,
        );
      },
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    _textAniCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double videoWidth = _controller.value.size?.width ?? 0;
    double videoHeight = _controller.value.size?.height ?? 0;

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
                        Text(_text,
                            style: Theme.of(context).textTheme.headlineLarge)
                      ],
                    ),
                    SizedBox(
                      height: screenHeight*0.05,
                    )
                  ],
                ),
              ),
              gravity: ToastGravity.BOTTOM);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: GestureDetector(
        // 스크린 터치시 화면 이동을 위한 위젯
        onTap: () {
          // _navToMain();
          updateComplete == true ? _navToMain() : null;
        },
        child: Center(
          child: Scaffold(
              body: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.8,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: videoWidth,
                          height: videoHeight,
                          child: _controller.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(
                                    _controller,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (updateComplete == true)
                      FadeTransition(
                        opacity: _animation,
                        child: Text("화면을 터치해 주세요",
                            style: Theme.of(context).textTheme.titleLarge),
                      )
                    else
                      SizedBox(),
                    SizedBox(
                      height: screenHeight*0.8,
                      // height: screenHeight*0.16,
                    )
                  ],
                ),
              ],
            )
          ])),
        ),
      ),
    );
  }
}
