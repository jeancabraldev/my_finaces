import 'dart:async';

import 'package:myFinances/src/resources/repository.dart';
import 'package:myFinances/src/utils/validator.dart';
import 'package:myFinances/src/utils/values/strings.dart';
import 'package:rxdart/rxdart.dart';

import '../bloc.dart';

class AuthenticationBloc implements Bloc {

  final _repository = Repository();
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();

  //Obtendo os dados de cada BehaviorSubject
  Observable<String> get name => _name.stream.transform(_validateName);
  Observable<String> get email => _email.stream.transform(_validateEmail);
  Observable<String> get password => _password.stream.transform(_validatePassword);
  Observable<bool> get signInStatus => _isSignedIn.stream;

  //Metodos que vão adicionar valor no fluxo de dados
  Function(String) get changeName => _name.sink.add; 
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(bool) get showProgressBar => _isSignedIn.sink.add;

    //Validando Nome usuário
    final _validateName = StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
      if(Validator.validateName(name)) {
        sink.add(name);
      } else {
        sink.addError(StringConstants.nameValidateMessege);
      }
    });

    //Validando Email usuário
    final _validateEmail = StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
      if(Validator.validateEmail(email)) {
        sink.add(email);
      } else {
        sink.addError(StringConstants.emailValidateMessage);
      }
    }); 

    //Validando senha usuário
    final _validatePassword = StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
      if(Validator.validatePassword(password)) {
        sink.add(password);
      } else {
        sink.addError(StringConstants.passwordValidateMessege);
      }
    });

    /*
     * Criando uma canmada extra de validação para garantir que o usuário não irá inserir 
     * informações incorretas nos campos do formulário 
    */
    bool validateEmailAndPassword() {
      if(_email.value != null && _email.value.isNotEmpty &&
         Validator.validateEmail(_email.value) && _password.value != null &&
         _password.value.isNotEmpty && Validator.validatePassword(_password.value)) {
        return true;
      }
      return false;
    }

    bool validateName() {
      return _name.value != null && _name.value.isNotEmpty &&
        Validator.validateName(_name.value);
    }

    //Metodos de autenticação Firebase
    Future<int> loginUser() async {
      //Barra progressiva
      showProgressBar(true);
      int response = await _repository.loginWithEmailAndPassword(_email.value, _password.value);
      showProgressBar(false);
      return response;
    }

    //Registrando usuário
    Future<int> registerUser() async {
      showProgressBar(true);
      int response = await _repository.singUpWithEmailAndPassword(_email.value, _password.value, _name.value);
      showProgressBar(false);
      return response;
    }

    @override
    void dispose() async {
  
      //Fechando variáveis
      await _email.drain();
      _email.close();
      await _name.drain();
      _name.close();
      await _password.drain();
      _password.close();
      await _isSignedIn.drain();
      _isSignedIn.close();
    }
}
  