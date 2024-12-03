import 'package:flutter/material.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/styles.dart';

class AccentButton extends StatelessWidget {
  const AccentButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(width200, height40),
        maximumSize: const Size.fromHeight(height40),
        backgroundColor: primaryColor,
        elevation: elevation0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius20),
        ),
        padding: const EdgeInsets.only(left: padding16, right: padding16),
      ),
      child: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        title,
        style: accentButtonStyle,
      ),
    );
  }
}
