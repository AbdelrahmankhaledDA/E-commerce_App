// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> _ar = {
    "Auth": {
      "Welcome to": "مرحبًا بك في",
      "Login": "تسجيل الدخول",
      "Register": "إنشاء حساب",
      "email": "البريد الإلكتروني",
      "password": "كلمة المرور",
      "Do not have an account yet": "ليس لديك حساب بعد",
      "username": "اسم المستخدم",
      "Full Name": "الاسم الكامل",
      "Confirm Password": "تأكيد كلمة المرور",
      "Already have an account": "لديك حساب بالفعل",
      "It is great to see you again": "من الرائع رؤيتك مرة أخرى",
      "Lets create your account": "دعنا ننشئ حسابك",
      "Login account": "تسجيل الدخول إلى الحساب",
      "Create account": "إنشاء حساب",
    },
    "Home": {
      "welcome": "مرحبًا بك في تطبيقنا",
      "description": "هذا هو التطبيق الذي يساعدك على إدارة مهامك اليومية",
    },
    "Cart": {"Finalize Purchase": "اتمام الشراء"},
    "Search": {
      "Start searching for products": "ابدأ بالبحث عن المنتجات",
      "Search For Anything": "ابحث عن أي شئ",
    },
    "Product": {
      "Details": "التفاصيل",
      "Added To Cart Successfully": "تمت الاضافة بنجاح",
      "Add To Cart": "أضف للعربة",
    },
  };
  static const Map<String, dynamic> _en = {
    "Auth": {
      "Welcome to": "Welcome to",
      "Login": "Login",
      "Register": "Register",
      "email": "email",
      "password": "password",
      "Do not have an account yet": "Do not have an account yet",
      "username": "username",
      "Full Name": "Full Name",
      "Confirm Password": "Confirm Password",
      "Already have an account": "Already have an account",
      "It is great to see you again": "It is great to see you again",
      "Lets create your account": "Lets create your account",
      "Login account": "Login account",
      "Create account": "Create account",
    },
    "Home": {"welcome": "welcome", "description": "description"},
    "Cart": {"Finalize Purchase": "Finalize Purchase"},
    "Search": {
      "Start searching for products": "Finalize Purchase",
      "Search For Anything": "Search For Anything",
    },
    "Product": {
      "Details": "Details",
      "Added To Cart Successfully": "Added To Cart Successfully",
      "Add To Cart": "Add To Cart",
    },
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": _ar,
    "en": _en,
  };
}
