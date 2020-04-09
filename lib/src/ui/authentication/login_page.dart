import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myFinances/src/ui/widgets/form_field_main.dart';
import 'package:myFinances/src/utils/values/colors.dart';

//Controlando animações
const double minHeight = 60;
const double maxHeight = 450;
const double minWidth = 250;
const double maxWidth = 400;
const double minBottomButtonsMargin = -170;
const double maxBottomButtonsMargin = 15;
const double maxFormsContainerMargin = 120;
const double minFormsContainerMargin = 20;

class LoginPage extends StatefulWidget {

  //Rota
  static const String ROUTENAME = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  //Controlando as animações
  AnimationController _animationController;

  bool _loginContainerOpened = false;
  bool _signUpContainerOpened = false;

  double _loginContainerHeight = minHeight;
  double _loginContainerWidth = minWidth;

  double _signUpContainerHeight = minHeight;
  double _signUpContainerWidth = minWidth;

  double _formsContainerMargin = maxFormsContainerMargin;

  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );
  }

  //Evitando vazamento de memória
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //Diminuindo o botão Sign Up
  void _scaleDownSignUpButton() {
    if(_signUpContainerOpened) {
      _signUpContainerHeight = minHeight;
      _signUpContainerWidth = minWidth;
      _signUpContainerOpened = false;
    }
  }

  //Fechando os botões
  void _scaleDownLoginButton() {
    if(_loginContainerOpened) {
      _loginContainerHeight = minHeight;
      _loginContainerWidth = minWidth;
      _loginContainerOpened = false;

    }
  }

  //Gerenciando o estado dos botões quando clicados
  void _toogleAuthButtonScale(bool islogin) {
    setState(() {
      if(islogin){
        _loginContainerHeight = _loginContainerHeight == maxHeight ? minHeight : maxHeight;
        _loginContainerWidth = _loginContainerWidth == maxWidth ? minWidth : maxWidth;
        //Diminuindo o botão Sign Up
        _scaleDownSignUpButton();
        _loginContainerOpened = !_loginContainerOpened;
      } else {
          _signUpContainerHeight = _signUpContainerHeight == maxHeight ? minHeight : maxHeight;
          _signUpContainerWidth = _signUpContainerWidth == maxWidth ? minWidth : maxWidth;
          //Diminuindo o botão Sign Up
          _scaleDownLoginButton();
          _signUpContainerOpened = !_signUpContainerOpened;
        }

        //Gerenciando as margens do container
        _formsContainerMargin = _formsContainerMargin == minFormsContainerMargin ? maxFormsContainerMargin : minFormsContainerMargin;
    });
  }

  //Animando logo do Google
  void _toogleNuLogoAndGoogleButton() {
    final bool isAnyContainerAnimationCompleted = _animationController.status == AnimationStatus.completed;
    //Controlando a direção
    _animationController.fling(velocity: isAnyContainerAnimationCompleted ? -2 : 2);
  }

  //Animando o tamanho dos botões entre o minimo e o maximo
  double lerp(double min, double max) => lerpDouble(min, max, _animationController.value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorMainPurple,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _animationController,
              builder: (context, child) {
                return Positioned.fill(
                top: lerp(maxBottomButtonsMargin, minBottomButtonsMargin),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 60,
                        margin: EdgeInsets.only(top: 50),
                        child: Image.asset(
                          'assets/images/nulogo.png',
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 40,
                        //margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },

          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                margin: EdgeInsets.only(top: _formsContainerMargin),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    //Sing Up Button
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: _loginContainerOpened ? Container() : GestureDetector(
                        onTap: () {
                          if(!_loginContainerOpened && !_signUpContainerOpened){
                            _toogleAuthButtonScale(false);
                            _toogleNuLogoAndGoogleButton();
                          }
                        },
                        child: AnimatedContainer(
                          width: _signUpContainerWidth,
                          height: _signUpContainerHeight,
                          duration: Duration(milliseconds: 500),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 25),
                          curve: Curves.fastOutSlowIn,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),    
                          ),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            child: _signUpContainerOpened 
                            ? Container(
                                alignment: Alignment.center,
                                child: Stack(              
                                  children: <Widget>[
                                    Positioned(
                                      top: 5,
                                      left: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          if(_signUpContainerOpened) {
                                            _toogleAuthButtonScale(false);
                                            _toogleNuLogoAndGoogleButton();
                                          }
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      top: 70,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[

                                            //Field Nome
                                            FormFieldMain(
                                              marginLeft: 20, 
                                              marginRight: 20, 
                                              marginTop: 0, 
                                              textInputType: TextInputType.text, 
                                              hintText: 'Nome', 
                                              obscured: false, 
                                              onChanged: (value){}
                                            ),

                                            //Field E-mail
                                            FormFieldMain(
                                              marginLeft: 20, 
                                              marginRight: 20, 
                                              marginTop: 15, 
                                              textInputType: TextInputType.emailAddress, 
                                              hintText: 'E-mail', 
                                              obscured: false, 
                                              onChanged: (value){}
                                            ),

                                            //Field Senha
                                            FormFieldMain(
                                              marginLeft: 20, 
                                              marginRight: 20, 
                                              marginTop: 15, 
                                              textInputType: TextInputType.numberWithOptions(), 
                                              hintText: 'Senha', 
                                              obscured: true, 
                                              onChanged: (value){}
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Positioned.fill(
                                      bottom: 15,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 30, right: 30),
                                            height: 60,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                width: 1,
                                                color: ColorConstant.colorMainPurple
                                              )
                                            ),
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                color: ColorConstant.colorMainPurple,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ) : Text(
                                    'Sign Up',
                                      style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                    //end Sing Up Button

                    //Login Button Animation
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 200),
                      child: _signUpContainerOpened ? Container() : GestureDetector(
                        onTap: () {
                          if(!_signUpContainerOpened && !_loginContainerOpened){
                            _toogleAuthButtonScale(true);
                            _toogleNuLogoAndGoogleButton();
                          }
                        },
                        child: AnimatedContainer(
                          width: _loginContainerWidth,
                          height: _loginContainerHeight,
                          duration: Duration(milliseconds: 500),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 25),
                          curve: Curves.fastOutSlowIn,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),    
                          ),
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 200),
                            child: _loginContainerOpened 
                            ? Container(
                                alignment: Alignment.center,
                                child: Stack(              
                                  children: <Widget>[
                                    Positioned(
                                      top: 5,
                                      left: 5,
                                      child: GestureDetector(
                                        onTap: () {
                                          if(_loginContainerOpened) {
                                            _toogleAuthButtonScale(true);
                                            _toogleNuLogoAndGoogleButton();
                                          }
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      top: 70,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: <Widget>[

                                            //Field E-mail
                                            FormFieldMain(
                                              marginLeft: 20, 
                                              marginRight: 20, 
                                              marginTop: 15, 
                                              textInputType: TextInputType.emailAddress, 
                                              hintText: 'E-mail', 
                                              obscured: false, 
                                              onChanged: (value){}
                                            ),

                                            //Field Senha
                                            FormFieldMain(
                                              marginLeft: 20, 
                                              marginRight: 20, 
                                              marginTop: 15, 
                                              textInputType: TextInputType.numberWithOptions(), 
                                              hintText: 'Senha', 
                                              obscured: true, 
                                              onChanged: (value){}
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Positioned.fill(
                                      bottom: 15,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(left: 30, right: 30),
                                            height: 60,
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                width: 1,
                                                color: ColorConstant.colorMainPurple
                                              )
                                            ),
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                color: ColorConstant.colorMainPurple,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ) : Text(
                                    'Login',
                                      style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ),
                    //end Login Button

                  ],
                ),
              ),
            ],
          ),

          /*
           * Criando autenticação com o google
           * Sign In with Google Button 
           */
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned.fill(
                bottom: lerp(maxBottomButtonsMargin, minBottomButtonsMargin),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.only(bottom: 15),
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Image.asset('assets/images/googleicon.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

        ],
      ),  
    );
  }
}