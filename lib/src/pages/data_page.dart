import 'package:flutter/material.dart';
import 'package:makeup2/src/model/makeup_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DataView extends StatelessWidget {
  final MakeupModel _makeup;
  DataView(this._makeup);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.pink[100],
        centerTitle: true,
        elevation: 0.0,
        flexibleSpace: Container(
          margin: EdgeInsets.all(40),
          child: Center(
            child: Text(
              _makeup.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Josefin',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.pink[100], Colors.pink[50], Colors.white])),
        child: Column(
          children: [
            SizedBox(height: 15),
            _HeaderTexts('brand'),
            _Bodys(_makeup.brand),
            SizedBox(height: 30.0),
            _HeaderTexts('product'),
            _Bodys(
              _makeup.productType,
            ),
            SizedBox(height: 30.0),
            _HeaderTexts('description'),
            _Bodys(_makeup.description),
            SizedBox(height: 30.0),
            _HeaderTexts('price'),
            Container(
              color: Colors.pink[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _makeup.price,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " €",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Josefin',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.pink[300]),
              child: Text(
                'Colors',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Josefin',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              height: 70,
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Expanded(
                child: SizedBox(
                  height: 5,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: _makeup.productColors.map((color) {
                        var colorH = color.hexValue.replaceAll('#', '');
                        if (colorH.length == 6) {
                          colorH = 'FF' + colorH;
                        }
                        final colorD = int.parse(colorH, radix: 16);
                        return Container(
                          margin: EdgeInsets.only(left: 5),
                          width: 30.0,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: Color(colorD)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.pink[200],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Product Image',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Josefin',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  onTap: () => {_launchInBrowser(_makeup.imageLink)},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderTexts extends StatelessWidget {
  final String _header;
  _HeaderTexts(this._header);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.pink[300]),
      child: Text(
        _header,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'Josefin',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}

class _Bodys extends StatelessWidget {
  @override
  final String _data;
  _Bodys(this._data);
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.pink[200],
      child: Text(
        _data,
        maxLines: 5,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontFamily: 'Josefin', fontSize: 20, color: Colors.white),
      ),
    );
  }
}

Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}
