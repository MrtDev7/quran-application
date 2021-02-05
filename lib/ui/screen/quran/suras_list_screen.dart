import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/ui/screen/quran/components/app_bar.dart';
import 'package:quran/ui/screen/quran/components/suras_list_card.dart';

class SurasListScreen extends StatefulWidget {
  SurasListScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SurasListScreenState();
  }
}

class SurasListScreenState extends State<SurasListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: quranListAppBar(),
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              width: double.infinity,
              color: Color(kLightPrimaryColor),
              child: Text(
                'إختر السورة',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                color: Color(0xffF4F4F4),
                child: ListView(
                  children: <Widget>[
                    SurasListCard(
                      number: 1,
                      name: 'الفاتحة',
                    ),
                    SurasListCard(
                      number: 2,
                      name: 'البقرة',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
