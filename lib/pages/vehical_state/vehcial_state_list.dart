import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/design/widgets/accent_button.dart';
import 'package:vehical_app/design/widgets/selectable_item.dart';
import 'package:vehical_app/models/states_model.dart';

class VehicalStateList extends StatelessWidget {
  const VehicalStateList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _saveButton(),
        ),
      ],
    );
  }

  Widget _list(BuildContext context) {
    final stateList = StateModel.stateList;
    return BlocBuilder<TransportBloc, TransportState>(
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
            int selectedStateIndex = -1;
            if (state is TransportSelectedState) {
              selectedStateIndex = state.selectedIndex;
            }
            final bool isSelected = selectedStateIndex == index;
            return SelectableItem(
              image: status.imagePath,
              leftPadding: padding16,
              title: status.action,
              isSelected: isSelected,
              onTap: () {
                context.read<TransportBloc>().add(OnChangedStateEvent(index));
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
        child: AccentButton(
          title: 'Сохранить',
          onTap: () {},
        ),
      ),
    );
  }
}
