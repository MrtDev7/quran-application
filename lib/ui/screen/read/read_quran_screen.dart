import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:quran/constants.dart';
import 'package:quran/providers/reading_setting_provider.dart';
import 'package:quran/ui/screen/read/components/aya_list_itam.dart';
import 'package:quran/ui/screen/read/components/detials_dialog.dart';

enum PlayerState { stopped, playing, paused }

typedef void OnError(Exception exception);

class ReadQuranScreen extends StatefulWidget {
  final int surasNumber;

  ReadQuranScreen({@required this.surasNumber});

  @override
  _ReadQuranScreenState createState() => _ReadQuranScreenState();
}

class _ReadQuranScreenState extends State<ReadQuranScreen> {
  int _selectedAya = 0;
  List<InlineSpan> ayats = [];
  Color color;
  String fontFamily;
  double size;
  Duration duration;
  Duration position;
  String ayaId;
  String suratId;


  AudioPlayer audioPlayer;

  String localFilePath;

  double fontSize = 25;

  PlayerState playerState = PlayerState.stopped;

  get isPlaying => playerState == PlayerState.playing;
  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  bool isMuted = false;

  StreamSubscription _positionSubscription;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  void initAudioPlayer() {
    audioPlayer = AudioPlayer();
    _positionSubscription = audioPlayer.onAudioPositionChanged
        .listen((p) => setState(() => position = p));
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((s) {
      if (s == AudioPlayerState.PLAYING) {
      } else if (s == AudioPlayerState.STOPPED) {
        onComplete();
        setState(() {
          position = duration;
        });
      }
    }, onError: (msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });
  }

  Future play(String url) async {
    await audioPlayer.play(url, isLocal: false);
    setState(() {
      playerState = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() => playerState = PlayerState.paused);
  }

  Future stop() async {
    await audioPlayer.stop();
    setState(() {
      playerState = PlayerState.stopped;
      position = Duration();
    });
  }

  void onComplete() {
    setState(() => playerState = PlayerState.stopped);
  }

  void _settingModelBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 0,
        context: (context),
        builder: (BuildContext contextBuilder) {
          return Container(
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -8),
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 70,
                  child: Material(
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.bookmark_border,
                            color: Colors.black38,
                          ),
                          Text(
                            'حفض',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: Material(
                        color: Color(kLightPrimaryColor),
                        child: InkWell(
                          onTap: () {
                            if (!isPlaying) {
                              play(
                                  'https://media.quranco.com/audio/addussary-64/${suratId + ayaId}.mp3');
                              print('playing..');
                            } else {
                              audioPlayer.stop();
                            }
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(2, 2),
                                      color: Colors.black12,
                                      blurRadius: 1,
                                      spreadRadius: 1),
                                ]),
                            child: SvgPicture.asset(
                              'assets/icons/microphone.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'سماع الأية',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black38),
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  child: Material(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);

                        DetialsDialog.detialDialog(
                          context: context,
                          aya: '',
                          ayaWithoutSymbols: '',
                          number: '',
                          surat: '',
                          tafsirJilal: '',
                          tafsirMoyasar: '',
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.info_outline, color: Colors.black38),
                          Text(
                            'تفاصيل',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        ReadingSettingProvider();
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            setState(() {
              _selectedAya = 0;
            });
          },
          child: Container(
            color: Color(0xFFE0FAE0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: AppBar(
                  elevation: 0,
                  title: Text(
                    'عودة',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  actions: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      child: FlatButton(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'تعديل',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadiusDirectional.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(15),
                                    child: ListView(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            'القرآن الكريم بصوت',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        DropdownButton(
                                          isExpanded: true,
                                          icon: Icon(
                                            Icons.arrow_drop_down_circle,
                                            color: Color(kLightPrimaryColor),
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('ياسر الدوسري'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text(' صلاح الهاشم'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text('حاتم فريد الواعر'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text('أحمد الطرابلسي'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text('عبدالباسط عبدالصمد'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text('إدريس أبكر'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text('أبو بكر الشاطري'),
                                            ),
                                            DropdownMenuItem(
                                              child: Text('صلاح بوخاطر'),
                                            ),
                                          ],
                                          onChanged: (value) {},
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: Text(
                                            'حجم الخط',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Slider(
                                            value: fontSize,
                                            min: 15,
                                            max: 100,
                                            onChanged: (value) {
                                              setState(() {
                                                fontSize = value;
                                              });
                                            })
                                      ],
                                    ),
                                  );
                                });
                          }),
                    ),
                  ],
                )),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text.rich(
                        TextSpan(children: [
                          aya(
                              number: 1,
                              ayaId: '001',
                              suratId: '002',
                              aya: 'الم',
                              color:
                                  _selectedAya == 1 ? Colors.red : Colors.black,
                              fontFamily: 'Quran',
                              size: fontSize,
                              longPress: () {
                                setState(() {
                                  _selectedAya = 1;
                                  ayaId = '001';
                                  suratId = '002';
                                });
                              }),
                          aya(
                              number: 2,
                              ayaId: '002',
                              suratId: '002',
                              aya:
                                  ' ذَٰلِكَ الْكِتَابُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِلْمُتَّقِينَ',
                              color:
                                  _selectedAya == 2 ? Colors.red : Colors.black,
                              fontFamily: 'Quran',
                              size: fontSize,
                              longPress: () {
                                setState(() {
                                  _selectedAya = 2;
                                  ayaId = '002';
                                  suratId = '002';
                                });

                                _settingModelBottomSheet(context);
                              }),
                          aya(
                              number: 3,
                              ayaId: '003',
                              suratId: '002',
                              aya:
                                  ' الَّذِينَ يُؤْمِنُونَ بِالْغَيْبِ وَيُقِيمُونَ الصَّلَاةَ وَمِمَّا رَزَقْنَاهُمْ يُنْفِقُونَ',
                              color:
                                  _selectedAya == 3 ? Colors.red : Colors.black,
                              fontFamily: 'Quran',
                              size: fontSize,
                              longPress: () {
                                setState(() {
                                  _selectedAya = 3;
                                  ayaId = '003';
                                  suratId = '002';
                                });
                                _settingModelBottomSheet(context);
                              }),
                          aya(
                              number: 4,
                              ayaId: '004',
                              suratId: '002',
                              aya:
                                  ' وَالَّذِينَ يُؤْمِنُونَ بِمَا أُنْزِلَ إِلَيْكَ وَمَا أُنْزِلَ مِنْ قَبْلِكَ وَبِالْآخِرَةِ هُمْ يُوقِنُونَ',
                              color:
                                  _selectedAya == 4 ? Colors.red : Colors.black,
                              fontFamily: 'Quran',
                              size: fontSize,
                              longPress: () {
                                setState(() {
                                  _selectedAya = 4;
                                  ayaId = '004';
                                  suratId = '002';
                                });
                                _settingModelBottomSheet(context);
                              }),
                          aya(
                              number: 5,
                              ayaId: '005',
                              suratId: '002',
                              aya:
                                  '  أُولَٰئِكَ عَلَىٰ هُدًى مِنْ رَبِّهِمْ ۖ وَأُولَٰئِكَ هُمُ الْمُفْلِحُونَ',
                              color:
                                  _selectedAya == 5 ? Colors.red : Colors.black,
                              fontFamily: 'Quran',
                              size: fontSize,
                              longPress: () {
                                setState(() {
                                  _selectedAya = 5;
                                  ayaId = '005';
                                  suratId = '002';
                                });
                                _settingModelBottomSheet(context);
                              }),
                          aya(
                              number: 6,
                              ayaId: '006',
                              suratId: '002',
                              aya:
                                  'إِنَّ الَّذِينَ كَفَرُوا سَوَاءٌ عَلَيْهِمْ أَأَنْذَرْتَهُمْ أَمْ لَمْ تُنْذِرْهُمْ لَا يُؤْمِنُونَ',
                              color:
                                  _selectedAya == 6 ? Colors.red : Colors.black,
                              fontFamily: 'Quran',
                              size: fontSize,
                              longPress: () {
                                setState(() {
                                  _selectedAya = 6;
                                  ayaId = '006';
                                  suratId = '002';
                                  _settingModelBottomSheet(context);
                                });
                              }),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
