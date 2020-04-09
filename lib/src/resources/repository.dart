import 'package:firebase_auth/firebase_auth.dart';
import 'package:myFinances/src/resources/authentication_resources.dart';

class Repository {
  final _authResources = AuthenticationResources();

  //Auhentication
  Stream<FirebaseUser> get onAuthStateChangeRepository => _authResources.onAuthStateChange; 
}