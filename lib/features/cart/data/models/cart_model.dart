import 'package:json_annotation/json_annotation.dart';

import 'cart_product_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int? id;
  final List<CartProductModel> products;
  final double? total;
  final double? discountTotal;
  final int? totalProducts;

  CartModel({
    required this.id,
    required this.products,
    required this.total,
    required this.discountTotal,
    required this.totalProducts,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
