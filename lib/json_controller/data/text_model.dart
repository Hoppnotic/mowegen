import 'package:json_annotation/json_annotation.dart';

//part 'localization_model.g_manual.dart';

@JsonSerializable(explicitToJson: true)
class LocalizationModel {
  LocalizationModel({
    //message
    this.push_button,
    this.stop,
    this.start,

  });
  //message
  String? push_button;
  String? stop;
  String? start;




/*  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizationModelToJson(this);*/
}