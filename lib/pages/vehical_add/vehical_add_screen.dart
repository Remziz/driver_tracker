import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_add_bloc/transport_add_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/blocs/transport_on_set_driver/transport_on_set_driver_bloc.dart';
import 'package:vehical_app/blocs/transport_on_set_state/transport_on_set_state_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/models/transport_image_model.dart';
import 'package:vehical_app/pages/vehical_add/widgets/driver_select_widget.dart';
import 'package:vehical_app/pages/vehical_add/widgets/state_select_widget.dart';

class VehicalAddScreen extends StatelessWidget {
  const VehicalAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transportList = TransportImageModel.transportImageList;
    return BlocListener<TransportAddBloc, TransportAddState>(
      listener: (context, state) {
        if (state is TransportAdded) {
          final userId = context.read<AuthBloc>().supabase.auth.currentUser!.id;
          context.read<TransportBloc>().add(LoadTransportData(userId));
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
          title: const Text(
            'Добавить транспорт',
            style: primaryTextStyle,
          ),
          centerTitle: true,
          backgroundColor: surfaceColor,
        ),
        body: Center(
          child: BlocBuilder<TransportAddBloc, TransportAddState>(
            builder: (context, state) {
              final String dropdownValue;
              if (state is TransportChangedDropdown) {
                dropdownValue = state.selectedItem;
              } else {
                dropdownValue = transportList[0].modelName;
              }
              final SvgPicture vehicalPicture =
                  TransportImageModel.getImageAddTransport(dropdownValue);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 10),
                      vehicalPicture,
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 40,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            iconSize: 24,
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                            dropdownColor: backgroundColor,
                            focusColor: backgroundColor,
                            items: transportList.map((transport) {
                              return DropdownMenuItem<String>(
                                value: transport.modelName,
                                child: Text(transport.modelName),
                              );
                            }).toList(),
                            onChanged: (String? selectedItem) {
                              context.read<TransportAddBloc>().add(
                                    SelectedNewTransportEvent(selectedItem!),
                                  );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DriverSelectWidget(),
                      ),
                      Expanded(
                        child: StateSelectWidget(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<TransportAddBloc, TransportAddState>(
                    builder: (context, state) {
                      final String modelName;
                      if (state is TransportChangedDropdown) {
                        modelName = state.selectedItem;
                      } else {
                        modelName = transportList[0].modelName;
                      }
                      return CupertinoButton(
                        color: primaryColor,
                        child: Text(
                          'Сохранить',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          final driverState =
                              context.read<TransportOnSetDriverBloc>().state;
                          final statusState =
                              context.read<TransportOnSetStateBloc>().state;
                          if (driverState is ChangedDriverState &&
                              statusState is ChangedStateOnAdd) {
                            final String driverName = driverState.name;
                            final String status = statusState.status;
                            context.read<TransportAddBloc>().add(
                                  OnAddTransportEvent(
                                      modelName, driverName, status),
                                );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  BlocBuilder<TransportAddBloc, TransportAddState>(
                    builder: (context, state) {
                      if (state is TransportAdding) {
                        return CircularProgressIndicator.adaptive();
                      } else if (state is TransportAddFailure) {
                        return Text(
                          'Произошла ошибка',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
