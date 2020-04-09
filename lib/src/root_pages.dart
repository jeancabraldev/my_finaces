import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myFinances/src/resources/repository.dart';
import 'package:myFinances/src/ui/authentication/login_page.dart';
import 'package:myFinances/src/ui/home/home_page.dart';

class RootPage extends StatefulWidget {

  //Definindo rota
  static const String ROUTENAME = 'root_page';

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  final Repository _repository = Repository();
  Stream<FirebaseUser> _currentUser;

  @override
  void initState() {
    _currentUser = _repository.onAuthStateChangeRepository;
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: _currentUser,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        /*
         * Verificando se existe usuário logado, caso exixte será redirecionado 
         * para home page caso não exista será redirecionado para login page 
         */
        return snapshot.hasData ? HomePage() : LoginPage();
      },
    );
  }
}