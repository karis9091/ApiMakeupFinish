import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:makeup2/src/model/makeup_model.dart';

class MakeupProvider {
  final String _url = 'http://makeup-api.herokuapp.com/api/v1/products.json';
  final http = Dio();

  //prueba
  Future<List<MakeupModel>> obtenerMakeup(int pagina) async {
    final response = await http.get(_url, queryParameters: {'offset': pagina});
    List<dynamic> responseData = response.data;
    return responseData.map((makeup) => MakeupModel.fromJson(makeup)).toList();
  }

  /* for (int i = 0; i < responseData.length; i++) {
      final responseMakeup = await http.get(responseData[i]);
      makeup.add(MakeupModel.fromJson(responseMakeup.data));
    } */

}
