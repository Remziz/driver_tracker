import 'package:flutter/material.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/design/widgets/accent_button.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.desription,
  });

  final String desription;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius8)),
      child: Padding(
        padding: const EdgeInsets.all(padding16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Ой-ой...',
              style: largeTextDialogStyle,
            ),
            const SizedBox(height: height8),
            Text(
              desription,
              style: mediumTextDialogStyle,
            ),
            const SizedBox(height: height20),
            Center(
              child: AccentButton(
                  title: 'Ok',
                  onTap: () {
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
