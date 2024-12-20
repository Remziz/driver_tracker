import 'package:flutter/material.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/pages/vehical_state/vehcial_state_list.dart';

class VehicalStatePage extends StatelessWidget {
  const VehicalStatePage({
    super.key,
    required this.driver,
  });

  final String driver;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Обновить статус водителя',
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
        child: VehicalStateList(
          driver: driver,
        ),
      ),
    );
  }
}
