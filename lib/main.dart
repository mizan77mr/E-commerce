import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';


import 'app/app.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Framework error
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Framework async error
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(CraftyBay());
}




  /*void paymentGatewayIntegration() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: "ostad6824b3be647db",
        store_passwd: "ostad6824b3be647db@ssl",
        total_amount: totalPrice,
        tran_id: "custom_transaction_id-001655ndggjhgftywe5454",
      ),
    );

    final response = await sslcommerz.payNow();

    if(response.status == 'VALID'){
      print('Payement success');
      print('TxID: ${response.tranId}');
      print('TxID: ${response.tranDate}');
    }

    if(response.status == 'Closed'){
      print('Payement closed');
    }
    if(response.status == 'FAILED'){
      print('Payement failed');
    }

  }
}*/