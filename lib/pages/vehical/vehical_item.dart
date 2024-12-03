import 'package:flutter/material.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/styles.dart';

class VehicalItem extends StatelessWidget {
  const VehicalItem({
    super.key,
    required this.onTap,
    required this.onStateTap,
  });

  final Function() onTap;
  final Function() onStateTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height64,
      child: Card(
        color: surfaceColor,
        elevation: elevation006,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(
              left: padding8,
              right: padding16,
            ),
            child: Row(
              children: <Widget>[
                vehicalMotorcycleImage,
                _title(),
                _state(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: padding6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'BMW GS-7638',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: bodyListItemStyle,
            ),
            // Text(
            //   'No driver',
            //   style: hintBodyListItemStyle,
            // ),
            RichText(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: const TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'Driver: ',
                  style: hintBodyListItemStyle,
                ),
                TextSpan(
                  text: 'Paul',
                  style: bodyListItemStyle,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _state() {
    return InkWell(
      onTap: onStateTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          vehicalPickUpImage,
          const Text(
            'pickup',
            style: smallBodyListItemStyle,
          )
        ],
      ),
    );
  }
}
