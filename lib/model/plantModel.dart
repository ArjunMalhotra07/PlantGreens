// To parse this JSON data, do
//
//     final plantModel = plantModelFromJson(jsonString);

import 'dart:convert';

PlantModel plantModelFromJson(String str) =>
    PlantModel.fromJson(json.decode(str));

String plantModelToJson(PlantModel data) => json.encode(data.toJson());

class PlantModel {
  PlantModel({
    this.description,
    this.plantName,
    this.price,
  });

  String? description;
  String? plantName;
  int? price;

  factory PlantModel.fromJson(Map<String, dynamic> json) => PlantModel(
        description: json["description"],
        plantName: json["plant_name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "plant_name": plantName,
        "price": price,
      };
}
