import 'package:flutter/material.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/utils/size_utils.dart';
import 'package:vehical_app/design/widgets/accent_button.dart';
import 'package:vehical_app/design/widgets/selectable_item.dart';

class DriverList extends StatefulWidget {
  const DriverList({super.key});

  @override
  State<DriverList> createState() => _DriverListState();
}

class _DriverListState extends State<DriverList> {
  int? _selectedDriverIndex;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _list(),
        Align(
          alignment: Alignment.bottomCenter,
          child: _saveButton(),
        ),
      ],
    );
  }

  Widget _list() {
    return ListView.separated(
      itemCount: 15,
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
        final bool isSelected = _selectedDriverIndex == index;
        return SelectableItem(
          image: accountUnknownImage,
          leftPadding: padding8,
          title: 'Серёга',
          isSelected: isSelected,
          onTap: () {
            setState(() {
              _selectedDriverIndex = index;
            });
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
