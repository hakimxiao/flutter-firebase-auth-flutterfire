import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Stream<User?> streamAuthStatus() {
  //   return auth.authStateChanges();
  // } *** VERSI KOMPLEKS

  Stream<User?> get streamAuthStatus => auth.authStateChanges(); // VERSI SIMPLE

  void signup() {}
  void login() {}
  void logout() {}
}
