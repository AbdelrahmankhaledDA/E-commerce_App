import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerceapp/core/network/apiService.dart';
import 'package:e_commerceapp/core/network/failures.dart';
import 'package:e_commerceapp/features/payment/model/payment_intnt_model.dart';
import 'package:e_commerceapp/features/payment/repo/payment_repo.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePayment implements PaymentRepo {
  ApiService apiservice;
  StripePayment(this.apiservice);
  @override
  Future<dynamic> makePayment(int? amount, String currency) async {
    final result = await _createPaymentEndPoint(amount, currency);
    result.fold((l) => print("Payment creation failed: ${l.message}"), (
      r,
    ) async {
      if (r.clientSecret != null) {
        await initPaymentSheet(r.clientSecret!);
        await Stripe.instance.presentPaymentSheet();
      } else {
        print("clientSecret is null");
      }
    });
  }

  Future<Either<Failures, PaymentIntntModel>> _createPaymentEndPoint(
    int? amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> data = {
        "amount": amount.toString(),
        "currency": currency,
      };

      final response = await apiservice.post(
        "https://api.stripe.com/v1/payment_intents",
        data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": ""},
        ),
      );

      return Right(PaymentIntntModel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        print("Stripe Error: ${e.response?.data}");
        return Left(ServerFailures.fromDioException(e));
      }
      return Left(ServerFailures(e.toString()));
    }
  }

  Future<void> initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "E-Commerce App",
      ),
    );
  }
}
