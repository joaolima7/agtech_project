import 'package:agtech/src/controller/user_controller.dart';
import 'package:agtech/src/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _userController = GetIt.I.get<UserController>();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/logo.png'),
      loginAfterSignUp: false,
      onLogin: (l) async {
        await _userController.login(
          UserEntity(email: l.name, password: l.password),
        );
        if (_userController.user != null) {
          return null;
        }
        return 'Falha no login, verifique as credenciais!';
      },
      onSignup: (l) async {
        final result = await _userController
            .signUp(UserEntity(email: l.name!, password: l.password!));

        if (result) {
          return null;
        }
        return 'Falha ao cadastrar-se, verifique as credenciais!';
      },
      onRecoverPassword: (l) {
        return null;
      },
      onSubmitAnimationCompleted: () =>
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false),
      messages: LoginMessages(
        signUpSuccess: 'Conta Criada com Sucesso!',
        passwordHint: 'Senha',
        userHint: 'E-mail',
        loginButton: 'Entrar',
        signupButton: 'Cadastre-se',
        goBackButton: 'Voltar',
        forgotPasswordButton: 'Esqueceu a Senha?',
        confirmSignupSuccess: 'Sucesso!',
      ),
      theme: LoginTheme(
        pageColorLight: Colors.white,
        accentColor: Colors.green,
        errorColor: Colors.red,
        primaryColor: Colors.green,
      ),
    );
  }
}
