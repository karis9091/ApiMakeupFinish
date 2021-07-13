import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MakeupModel {
  int id;
  String brand;
  String name;
  String price;
  String imageLink;
  String description;
  String productType;
  List<ProductColors> productColors;

  MakeupModel(
      {this.id,
      this.brand,
      this.name,
      this.price,
      this.imageLink,
      this.description,
      this.productType,
      this.productColors});

  factory MakeupModel.fromJson(Map<String, dynamic> makeup) => MakeupModel(
        id: makeup['id'],
        brand: makeup['brand'],
        name: makeup['name'],
        price: makeup['price'],
        imageLink: makeup['image_link'],
        description: makeup['description'],
        productType: makeup['product_type'],
        productColors: makeup['product_colors']
            .map((productColors) => ProductColors.fromJson(productColors))
            .toList()
            .cast<ProductColors>(),
      );
}

class ProductColors {
  //String colourName;
  String hexValue;
  ProductColors({this.hexValue});

  factory ProductColors.fromJson(Map<String, dynamic> colors) => ProductColors(
        hexValue: colors['hex_value'],
        //colourName: colors['productColors']['colour_name'],
      );
}
