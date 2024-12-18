import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/bloc/auth_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/pages/vehical/vehical_list.dart';

class VehicalPage extends StatelessWidget {
  const VehicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login_screen');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: 'Выйти',
            onPressed: () {
              context.read<AuthBloc>().add(LogOut());
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
          title: const Text(
            'Диспетчер транспорта',
            style: primaryTextStyle,
          ),
          centerTitle: true,
          backgroundColor: surfaceColor,
        ),
        body: Container(
          color: backgroundColor,
          child: const VehicalList(),
        ),
      ),
    );
  }
}
