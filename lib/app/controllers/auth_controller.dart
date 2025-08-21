// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_firebase_app/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Stream<User?> streamAuthStatus() {
  //   return auth.authStateChanges();
  // } *** VERSI KOMPLEKS

  Stream<User?> get streamAuthStatus => auth.authStateChanges(); // VERSI SIMPLE

  void signup(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      // wajib dideklarasikan jika pakai routing
      Get.offNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    // wajib dideklarasikan jika pakai routing
    await FirebaseAuth.instance.signOut();

    Get.offNamed(Routes.LOGIN);
  }
}


// KENAPA ROUTING ?. KENAPA TIDAK HOME ?
/**
KESIMPULAN : 
  Jadi dia bisa menyebabkan error karena binding itu di proses lambat sedangkan Home Dia langsung nembak sehingga login controller
  di anggap belum di put.

================================================================================================================================================
Oke, saya jelaskan singkat dan jelas ya:

Kalau kita **pakai `home:` langsung di `MaterialApp`**, maka widget pertama yang dibuka adalah `home` itu sendiri. 
Misalnya `home: StreamBuilder(...)`, maka dia akan otomatis ngecek stream (misalnya auth state), lalu berpindah ke halaman 
login/dashboard sesuai kondisi. Kekurangannya:

Semua logika auth langsung tertanam di `home`, jadi tidak fleksibel.
Sulit dikontrol kalau mau navigasi lebih kompleks (misalnya splash → onboarding → login → dashboard).

Sedangkan kalau kita pakai **`initialRoute` + `routes` (atau GetX: `initialRoute`, `Get.toNamed`)**, maka:

Kita bisa atur jalur navigasi sejak awal sesuai kondisi auth (misalnya kalau user belum login → langsung ke `/login`, 
kalau sudah login → langsung ke `/dashboard`).
Navigasi lebih terstruktur, terpisah dari UI widget.
Lebih mudah maintain dan scalable kalau aplikasi makin besar.

👉 Jadi intinya:

* **`home:`** cocok untuk app kecil/simple, karena auto pindah dari stream builder.
* **`initialRoute` / routing:** lebih bagus untuk **auth flow yang kompleks**, karena navigasi ditentukan di level route, bukan hanya UI.

Mau saya bikinkan contoh kecil perbandingan kode `home:` vs `initialRoute` supaya lebih kelihatan bedanya?

 */