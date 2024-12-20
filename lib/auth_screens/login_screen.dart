import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          final userId = context.read<AuthBloc>().supabase.auth.currentUser!.id;
          context.read<TransportBloc>().add(LoadTransportData(userId));
          Navigator.of(context).pushReplacementNamed('/vehical_screen');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Авторизация',
            style: primaryTextStyle,
          ),
          centerTitle: true,
          backgroundColor: surfaceColor,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 25,
          ),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Электронная почта:',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    border: InputBorder.none,
                    hintText: 'Пароль:',
                  ),
                ),
                const SizedBox(height: 10),
                CupertinoButton(
                  color: primaryColor,
                  child: Text(
                    'Войти',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          OnLoginButtonEvent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ),
                        );
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<AuthBloc, AuthBlocState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return CircularProgressIndicator.adaptive();
                    } else if (state is AuthFailure) {
                      return Text(
                        'Произошла ошибка',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
