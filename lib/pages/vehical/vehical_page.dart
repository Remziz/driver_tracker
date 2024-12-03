import 'package:flutter/material.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/pages/vehical/vehical_list.dart';

class VehicalPage extends StatelessWidget {
  const VehicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Диспетчер транспорта',
          style: primaryTextStyle,
        ),
        centerTitle: true,
        backgroundColor: surfaceColor,
      ),
      body: Container(
        color: backgroundColor,
        child: const VehicalList(),
      ),
    );
  }
}
