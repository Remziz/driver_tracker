import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vehical_app/design/colors.dart';
import 'package:vehical_app/design/demensions.dart';
import 'package:vehical_app/design/images.dart';
import 'package:vehical_app/design/styles.dart';

class SelectableItem extends StatelessWidget {
  const SelectableItem({
    super.key,
    required this.image,
    required this.leftPadding,
    required this.onTap,
    required this.title,
    required this.isSelected,
  });

  final SvgPicture image;
  final double leftPadding;
  final Function() onTap;
  final String title;
  final bool isSelected;

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
            padding: EdgeInsets.only(
              left: leftPadding,
              right: padding16,
            ),
            child: Row(
              children: <Widget>[
                image,
                const SizedBox(width: width16),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: bodyListItemStyle,
                  ),
                ),
                if (isSelected) checkImage
              ],
            ),
          ),
        ),
      ),
    );
  }
}
