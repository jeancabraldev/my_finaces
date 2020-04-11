import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthenticationResources {

  /*
   * Autenticando usuário
   */

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChange => _firebaseAuth.onAuthStateChanged;

  Future<int> singUpWithEmailAndPassword(String name, String email, String password) async {
    try {
      AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
        await setUserName(authResult.user, name);
        return 1;
    } on PlatformException catch(e){
      //Erros de permissões
      print('Exception: Authentication: ${e.toString()}');
      return -1;
    }catch(e){
      print('Exception: Authentication: ${e.toString()}');
      return -2;
    }
  }

  Future<int> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 1;
    } on PlatformException catch(e){
      print('Exception: Authentication: ${e.toString()}');
      return -1;  
    } catch(e){
      print('Exception: Authentication: ${e.toString()}');
      return -2;
    }
  }

  Future<void> get signOut async {
    _firebaseAuth.signOut();
  }

  //Setando o nome do uasuário caso o cadastrado seja efetuado com sucesso
  Future<void> setUserName(FirebaseUser user, String name) async {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    await user.updateProfile(updateInfo);
  }
}