import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:makeup2/src/model/makeup_model.dart';
import 'package:makeup2/src/pages/data_page.dart';
import 'package:makeup2/src/provider/makeup_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final _makeupState = Get.put(MakeupState());
    _makeupState.obtenerMakeup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0.0,
        backgroundColor: Colors.pink,
        title: Text('Make Up', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              iconSize: 35,
              onPressed: () => {},
              icon: SvgPicture.asset(
                "assets/lapiz-labial.svg",
                width: 40,
              ))
        ],
      ),
      body: Stack(
        children: [_Fondo(), _MakeupView()],
      ),
    );
  }
}

class _MakeupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<MakeupState>(builder: (MakeupState makeupState) {
        List<MakeupModel> lipsticks = [];
        for (var i = 0; i < makeupState.makeups.length; i++) {
          final _makeup = makeupState.makeups[i];
          if (_makeup.productType == 'lipstick') {
            lipsticks.add(makeupState.makeups[i]);
          }
        }

        return GridView.builder(
          itemCount: lipsticks.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
          ),
          itemBuilder: (BuildContext context, int i) {
            final maquillaje = lipsticks[i];

            return GestureDetector(
              child: Container(
                margin: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    maquillaje.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Josefin',
                        fontSize: 23),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DataView(maquillaje)));
              },
            );
          },
        );
      }),
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Column(
//           children: [_Fondo()],
//         ),
//       ),
//     );
//   }
// }

// class _ImgPestanas extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Image.asset('assets/pestanas.png'),
//     );
//   }
// }

class _Fondo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/maquillaje_fondo.jpg'),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
