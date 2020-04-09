import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationResources {

  /*
   * Autenticando usuário
   */

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChange => _firebaseAuth.onAuthStateChanged;

}