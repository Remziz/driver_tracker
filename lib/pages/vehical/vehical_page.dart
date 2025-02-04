import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/blocs/transport_delete_bloc/transport_delete_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/pages/vehical/vehical_list.dart';

class VehicalPage extends StatelessWidget {
  const VehicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is AuthSucess) {
          final userId = context.read<AuthBloc>().supabase.auth.currentUser!.id;
          context.read<TransportBloc>().add(LoadTransportData(userId));
        }
        if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacementNamed('/login_screen');
        }
      },
      child: BlocListener<TransportDeleteBloc, TransportDeleteState>(
        listener: (context, state) {
          if (state is TransportDeletedState) {
            final userId =
                context.read<AuthBloc>().supabase.auth.currentUser!.id;
            context.read<TransportBloc>().add(LoadTransportData(userId));
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
            actions: [
              IconButton(
                onPressed: () {
                  final userId =
                      context.read<AuthBloc>().supabase.auth.currentUser!.id;
                  context.read<TransportBloc>().add(LoadTransportData(userId));
                },
                icon: Icon(Icons.refresh),
              )
            ],
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
      ),
    );
  }
}
