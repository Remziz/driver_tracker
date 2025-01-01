import 'package:flutter/material.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/pages/driver/driver_list.dart';

class DriverPage extends StatelessWidget {
  const DriverPage({
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Изменить водителя',
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
        child: DriverList(
          id: id,
          status: status,
          transportModel: transportModel,
        ),
      ),
    );
  }
}
