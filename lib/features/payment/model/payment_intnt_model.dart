import 'package:json_annotation/json_annotation.dart';
part 'payment_intnt_model.g.dart';

@JsonSerializable()
class PaymentIntntModel {
  @JsonKey(name: 'client_secret')
  final String? clientSecret;

  PaymentIntntModel({required this.clientSecret});

  factory PaymentIntntModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentIntntModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentIntntModelToJson(this);
}
