import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/blocs/transport_driver/transport_driver_bloc.dart';
import 'package:vehical_app/blocs/transport_on_change_driver/transport_on_change_driver_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/design/widgets/selectable_item.dart';
import 'package:vehical_app/models/driver_model.dart';

class DriverList extends StatelessWidget {
  const DriverList({
    super.key,
    required this.id,
    required this.status,
    required this.transportModel,
  });

  final int id;
  final String transportModel;
  final String status;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransportOnChangeDriverBloc,
        TransportOnChangeDriverState>(
      listener: (context, state) {
        if (state is ChangedExistDriverSuccesfully) {
          final userId = context.read<AuthBloc>().supabase.auth.currentUser!.id;
          context.read<TransportBloc>().add(LoadTransportData(userId));
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: backgroundColor,
        child: Stack(
          children: <Widget>[
            BlocBuilder<TransportDriverBloc, TransportDriverState>(
              builder: (context, state) {
                if (state is TransportDriverLoaded) {
                  final List<DriverModel> driverList = state.driverList;
                  return BlocBuilder<TransportOnChangeDriverBloc,
                      TransportOnChangeDriverState>(
                    builder: (context, state) {
                      return Stack(
                        children: [
                          ListView.separated(
                            itemCount: driverList.length,
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
                              final driver = driverList[index];
                              int? selectedIndex;
                              if (state is ChangingExistDriverState) {
                                selectedIndex = state.index;
                              }
                              final bool isSelected = selectedIndex == index;
                              return SelectableItem(
                                image: accountUnknownImage,
                                leftPadding: padding8,
                                title: driver.name,
                                isSelected: isSelected,
                                onTap: () {
                                  context
                                      .read<TransportOnChangeDriverBloc>()
                                      .add(
                                        ChangingExistDriverEvent(
                                          index,
                                          driver.name,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                          SaveButton(
                            id: id,
                            status: status,
                            transportModel: transportModel,
                          ),
                        ],
                      );
                    },
                  );
                } else if (state is TransportDriverLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.id,
    required this.status,
    required this.transportModel,
  });

  final int id;
  final String status;
  final String transportModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportOnChangeDriverBloc,
        TransportOnChangeDriverState>(
      builder: (context, state) {
        if (state is ChangingExistDriverState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoButton(
                color: primaryColor,
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  context.read<TransportOnChangeDriverBloc>().add(
                      SaveChangeToExistDriverEvent(
                          id, status, state.driverName, transportModel));
                },
              ),
            ),
          );
        } else if (state is ChangedLoadDriverState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
