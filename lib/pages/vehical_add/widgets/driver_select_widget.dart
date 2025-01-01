import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_driver/transport_driver_bloc.dart';
import 'package:vehical_app/blocs/transport_on_set_driver/transport_on_set_driver_bloc.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/styles.dart';

class DriverSelectWidget extends StatelessWidget {
  const DriverSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            SizedBox(width: 15),
            accountUnknownImage,
            SizedBox(width: 5),
            Expanded(
              child: BlocBuilder<TransportOnSetDriverBloc,
                  TransportOnSetDriverState>(
                builder: (context, state) {
                  if (state is TransportOnSetDriverInitial ||
                      state is ChangingDriverState) {
                    return Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      'Водитель не выбран!',
                      style: bodyListItemStyle,
                    );
                  } else if (state is ChangedDriverState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Выбран водитель:',
                          style: hintBodyListItemStyle,
                        ),
                        SizedBox(height: 5),
                        Text(
                          state.name,
                          style: bodyListItemStyle,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        final String userId =
            context.read<AuthBloc>().supabase.auth.currentUser!.id;
        context
            .read<TransportDriverBloc>()
            .add(TransportDriverLoadEvent(userId));
        await Navigator.of(context).pushNamed('/select_driver');
      },
    );
  }
}
