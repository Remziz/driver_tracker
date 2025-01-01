import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/transport_driver/transport_driver_bloc.dart';
import 'package:vehical_app/blocs/transport_on_set_driver/transport_on_set_driver_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/design/widgets/selectable_item.dart';
import 'package:vehical_app/models/driver_model.dart';

class SelectDriverScreen extends StatelessWidget {
  const SelectDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransportOnSetDriverBloc, TransportOnSetDriverState>(
      listener: (context, state) {
        if (state is ChangedDriverState) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Выбор водителя',
            style: primaryTextStyle,
          ),
          centerTitle: true,
          backgroundColor: surfaceColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: backgroundColor,
          child: Stack(
            children: <Widget>[
              BlocBuilder<TransportDriverBloc, TransportDriverState>(
                builder: (context, state) {
                  if (state is TransportDriverLoaded) {
                    final List<DriverModel> driverList = state.driverList;
                    return BlocBuilder<TransportOnSetDriverBloc,
                        TransportOnSetDriverState>(
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
                                if (state is ChangingDriverState) {
                                  selectedIndex = state.id;
                                }
                                final bool isSelected = selectedIndex == index;
                                return SelectableItem(
                                  image: accountUnknownImage,
                                  leftPadding: padding8,
                                  title: driver.name,
                                  isSelected: isSelected,
                                  onTap: () {
                                    context
                                        .read<TransportOnSetDriverBloc>()
                                        .add(
                                          DriverChangedEvent(
                                              driver.name, index),
                                        );
                                  },
                                );
                              },
                            ),
                            SaveButton(),
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
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportOnSetDriverBloc, TransportOnSetDriverState>(
      builder: (context, state) {
        if (state is ChangingDriverState) {
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
                  context.read<TransportOnSetDriverBloc>().add(
                        DriverSaveChangedEvent(state.id, state.name),
                      );
                },
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
