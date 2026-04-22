import 'package:e_commerceapp/features/home/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_products_model.g.dart';

@JsonSerializable()
class ResponseProductsModel {
  @JsonKey(name: 'products')
  List<ProductModel> product;
  int total;
  int skip;
  int limit;
  ResponseProductsModel({
    required this.product,
    required this.total,
    required this.skip,
    required this.limit,
  });
  factory ResponseProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseProductsModelToJson(this);
}
