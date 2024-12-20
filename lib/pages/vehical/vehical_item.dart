import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/transport_bloc/transport_bloc.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/styles.dart';

class VehicalItem extends StatelessWidget {
  const VehicalItem({
    super.key,
    required this.onTap,
    required this.onStateTap,
    required this.model,
    required this.driver,
    required this.status,
  });

  final Function() onTap;
  final Function() onStateTap;
  final String model;
  final String driver;
  final String status;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransportBloc, TransportState>(
        builder: (context, state) {
      if (state is TransportLoaded) {
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
                    _title(model, driver),
                    _state(status),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _title(String model, String driver) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          left: padding6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              model,
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
              text: TextSpan(children: <TextSpan>[
                const TextSpan(
                  text: 'Driver: ',
                  style: hintBodyListItemStyle,
                ),
                TextSpan(
                  text: driver,
                  style: bodyListItemStyle,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _state(String status) {
    return InkWell(
      onTap: onStateTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          vehicalPickUpImage,
          Text(
            status,
            style: smallBodyListItemStyle,
          )
        ],
      ),
    );
  }
}
