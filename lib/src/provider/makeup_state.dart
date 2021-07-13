import 'package:flutter/material.dart';
import 'package:makeup2/src/provider/makeup_provider.dart';
import 'package:makeup2/src/model/makeup_model.dart';
import 'package:get/get.dart';

class MakeupState extends GetxController {
  List<MakeupModel> makeups = [];
  int _paginado = 0;
  final _makeupProvider = MakeupProvider();

  Future<void> obtenerMakeup() async {
    final make = await _makeupProvider.obtenerMakeup(_paginado);
    makeups.addAll(make);
    _paginado += 20;
    update();
  }
}
