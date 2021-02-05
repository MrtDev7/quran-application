import 'package:flutter/material.dart';
import 'package:quran/constants.dart';

class DetialsDialog {
  static Future detialDialog(
      {context,
      aya,
      surat,
      number,
      ayaWithoutSymbols,
      tafsirJilal,
      tafsirMoyasar}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  aya,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Quran',
                                    fontWeight: FontWeight.bold,
                                    color: Color(kLightPrimaryColor),
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  color: Colors.black26,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color(kLightPrimaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      ' الآية 2 من سورة البقرة بدون تشكيل',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    ayaWithoutSymbols,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Color(kLightPrimaryColor),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      ' تفسير الجلالين',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(tafsirJilal),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(kLightPrimaryColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'تفسير الميسر',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(tafsirMoyasar),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'تم',
                            style: TextStyle(
                              color: Color(kLightPrimaryColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
