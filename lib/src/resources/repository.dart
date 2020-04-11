import 'package:firebase_auth/firebase_auth.dart';
import 'package:myFinances/src/resources/authentication_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();

  //Auhentication
  Stream<FirebaseUser> get onAuthStateChangeRepository => _authResources.onAuthStateChange;
  Future<int> singUpWithEmailAndPassword(String email, String password, String name) => 
    _authResources.singUpWithEmailAndPassword(name, email, password);
  Future<int> loginWithEmailAndPassword(String email, String password) =>
    _authResources.loginWithEmailAndPassword(email, password);
  Future<void> signOut() => _authResources.signOut;
}