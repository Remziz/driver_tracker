import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/blocs/transport_driver/transport_driver_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/dialogs/edit_vehical_dialog.dart';
import 'package:vehical_app/models/states_model.dart';
import 'package:vehical_app/models/transport_image_model.dart';
import 'package:vehical_app/pages/driver/driver_page.dart';
import 'package:vehical_app/pages/vehical/vehical_item.dart';
import 'package:vehical_app/pages/vehical_state/vehical_state_page.dart';

class VehicalList extends StatelessWidget {
  const VehicalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _updateButton(context),
        ),
      ],
    );
  }

  Widget _list(BuildContext context) {
    return BlocBuilder<TransportBloc, TransportState>(
        builder: (context, state) {
      if (state is TransportLoaded) {
        final transportData = state.transportData;
        return ListView.separated(
          itemCount: transportData.length,
          padding: EdgeInsets.only(
            left: padding16,
            right: padding16,
            top: padding16,
            bottom: getListBottomPadding(context),
          ),
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: height8,
            );
          },
          itemBuilder: (context, index) {
            final transport = transportData[index];
            final imageTransport =
                TransportImageModel.getImageTransport(transport.model);
            final imageState = StateModel.getImageState(transport.status);
            return VehicalItem(
              onTap: () async {
                final String userId =
                    context.read<AuthBloc>().supabase.auth.currentUser!.id;
                context
                    .read<TransportDriverBloc>()
                    .add(TransportDriverLoadEvent(userId));
                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return DriverPage(
                        id: transport.id,
                        status: transport.status,
                        transportModel: transport.model,
                      );
                    },
                  ),
                );
              },
              onLongPress: () async {
                await showDialog(
                  context: context,
                  builder: (context) => EditVehicalDialog(
                    id: transport.id,
                    status: transport.status,
                    driver: transport.driver,
                    transportModel: transport.model,
                  ),
                );
              },
              onStateTap: () async {
                await _showVehicalStatePage(
                    context, transport.id, transport.driver, transport.model);
              },
              model: transport.model,
              driver: transport.driver,
              status: transport.status,
              imageState: imageState,
              imageTransport: imageTransport,
            );
          },
        );
      } else {
        return Container();
      }
    });
  }

  Widget _updateButton(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: padding16,
          left: padding16,
          right: padding16,
        ),
        child: CupertinoButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/vehical_add');
          },
          color: primaryColor,
          child: Text(
            'Добавить',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showVehicalStatePage(BuildContext context, int id,
      String driver, String transportModel) async {
    await Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return VehicalStatePage(
        id: id,
        driver: driver,
        transportModel: transportModel,
      );
    }));
  }
}
