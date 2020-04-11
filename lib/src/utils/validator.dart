class Validator {

  //Validando Name
  static bool validateName(String value) {
    if(value.length < 3) {
      return false;
    }
    return true;
  }

  //Validando E-mail
  static bool validateEmail(String value) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value);
  }

  //Validando Senha
  static bool validatePassword(String value) {
    if(value.length < 6) {
      return false;
    }
    return true;
  }
}