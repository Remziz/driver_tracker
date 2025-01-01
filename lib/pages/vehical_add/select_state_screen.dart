import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/transport_on_set_state/transport_on_set_state_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/design/widgets/selectable_item.dart';
import 'package:vehical_app/models/states_model.dart';

class SelectStateScreen extends StatelessWidget {
  const SelectStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransportOnSetStateBloc, TransportOnSetStateState>(
      listener: (context, state) {
        if (state is ChangedStateOnAdd) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text(
            'Выбрать статус водителя',
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
        body: Stack(
          children: [
            SelectStateList(),
            SaveButton(),
          ],
        ),
      ),
    );
  }
}

class SelectStateList extends StatelessWidget {
  const SelectStateList({super.key});

  @override
  Widget build(BuildContext context) {
    final stateList = StateModel.stateList;
    return BlocBuilder<TransportOnSetStateBloc, TransportOnSetStateState>(
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
            if (state is ChangingStateOnAdd) {
              selectedStateIndex = state.index;
            }
            final bool isSelected = selectedStateIndex == index;
            return SelectableItem(
              image: status.imagePath,
              leftPadding: padding16,
              title: status.action,
              isSelected: isSelected,
              onTap: () {
                context.read<TransportOnSetStateBloc>().add(
                      StateChangedEvent(index, status.action),
                    );
              },
            );
          },
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportOnSetStateBloc, TransportOnSetStateState>(
      builder: (context, state) {
        if (state is ChangingStateOnAdd) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoButton(
                color: primaryColor,
                child: Text(
                  'Сохранить',
                  style: TextStyle(color: backgroundColor),
                ),
                onPressed: () {
                  context.read<TransportOnSetStateBloc>().add(
                        StateSaveChangedEvent(state.index, state.status),
                      );
                },
              ),
            ),
          );
        } else if (state is ChangedStateOnAddLoading) {
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
