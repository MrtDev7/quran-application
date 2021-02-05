import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quran/constants.dart';
import 'package:quran/ui/screen/home/components/main_category_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
        ],
        title: Text(
          homeTitle,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25),
        height: size.height,
        width: double.infinity,
        color: Color(kLightPrimaryColor),
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/icons/quran.svg',
                  height: 60,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  homeSubTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                width: size.width * 0.85,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: <Widget>[
                    MainCategoryCard(
                      title: 'سماع القرأن',
                      press: () {},
                      iconSrc: 'assets/icons/microphone.svg',
                    ),
                    MainCategoryCard(
                      title: 'المنبه اليومي',
                      press: () {},
                      iconSrc: 'assets/icons/notification.svg',
                    ),
                    MainCategoryCard(
                      title: 'المصحف مع التفسير',
                      press: () {
                        Navigator.pushNamed(context, '/suras_list');
                      },
                      iconSrc: 'assets/icons/quran_icon.svg',
                    ),
                    MainCategoryCard(
                      title: 'أوقات الصلاة',
                      press: () {},
                      iconSrc: 'assets/icons/pray.svg',
                    ),
                    MainCategoryCard(
                      title: 'المقرؤون',
                      press: () {},
                      iconSrc: 'assets/icons/customer.svg',
                    ),
                    MainCategoryCard(
                      title: 'الأذكار',
                      press: () {},
                      iconSrc: 'assets/icons/idea.svg',
                    ),
                    MainCategoryCard(
                      title: 'الأذكار',
                      press: () {},
                      iconSrc: 'assets/icons/idea.svg',
                    ),
                    MainCategoryCard(
                      title: 'القبلة',
                      press: () {},
                      iconSrc: 'assets/icons/compass.svg',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
