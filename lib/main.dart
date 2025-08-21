// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_firebase_app/app/controllers/auth_controller.dart';
import 'package:my_firebase_app/app/modules/home/views/home_view.dart';
import 'package:my_firebase_app/app/modules/login/views/login_view.dart';
import 'package:my_firebase_app/app/utils/loading.dart';
import 'app/routes/app_pages.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authC = Get.put(
    AuthController(),
    permanent: true,
  ); // diakan selalu dijalankan dikondisi apapun

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.active) {
          print(snapshot.data); // jika null maka user belum login.
          return GetMaterialApp(
            title: "Application",
            // initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
            getPages: AppPages.routes,
            home: snapshot.data != null ? HomeView() : LoginView(),
          );
        }
        return LoadingView();
      },
    );
  }
}
