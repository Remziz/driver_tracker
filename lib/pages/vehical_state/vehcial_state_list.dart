import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/blocs/transport_on_change_state_bloc/transport_on_change_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/design/widgets/selectable_item.dart';
import 'package:vehical_app/models/states_model.dart';

class VehicalStateList extends StatelessWidget {
  const VehicalStateList({
    super.key,
    required this.driver,
    required this.id,
    required this.transportModel,
  });

  final int id;
  final String driver;
  final String transportModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransportOnChangeBloc, TransportOnChangeState>(
      listener: (context, state) async {
        if (state is ChangedStateSuccessuful) {
          final userId = context.read<AuthBloc>().supabase.auth.currentUser!.id;
          context.read<TransportBloc>().add(LoadTransportData(userId));
          Navigator.of(context).pop();
        }
      },
      child: Stack(
        children: <Widget>[
          _list(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: _saveButton(),
          ),
        ],
      ),
    );
  }

  Widget _list(BuildContext context) {
    final stateList = StateModel.stateList;
    return BlocBuilder<TransportOnChangeBloc, TransportOnChangeState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: stateList.length,
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
            final status = stateList[index];
            int? selectedStateIndex;
            if (state is TransportChangedState) {
              selectedStateIndex = state.selectedIndex;
            }
            final bool isSelected = selectedStateIndex == index;
            return SelectableItem(
              image: status.imagePath,
              leftPadding: padding16,
              title: status.action,
              isSelected: isSelected,
              onTap: () {
                context.read<TransportOnChangeBloc>().add(
                      OnChangeStateEvent(index, status.action, driver),
                    );
              },
            );
          },
        );
      },
    );
  }

  Widget _saveButton() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: padding16,
          left: padding16,
          right: padding16,
        ),
        child: BlocBuilder<TransportOnChangeBloc, TransportOnChangeState>(
          builder: (context, state) {
            if (state is TransportChangedState) {
              return CupertinoButton(
                color: primaryColor,
                child: Text(
                  'Сохранить',
                  style: TextStyle(
                    color: backgroundColor,
                  ),
                ),
                onPressed: () {
                  context.read<TransportOnChangeBloc>().add(
                        OnSaveButtonEvent(
                            id, state.driver, transportModel, state.action),
                      );
                },
              );
            } else if (state is ChangingState) {
              return CircularProgressIndicator.adaptive();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
