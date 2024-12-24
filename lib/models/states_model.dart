import 'package:flutter_svg/svg.dart';
import 'package:vehical_app/design/images.dart';

class StateModel {
  final String action;
  final SvgPicture imagePath;

  StateModel({
    required this.action,
    required this.imagePath,
  });

  static List<StateModel> stateList = [
    StateModel(
      action: 'Требует ремонта',
      imagePath: SvgPicture.asset('assets/svg/repair.svg'),
    ),
    StateModel(
      action: 'На парковке',
      imagePath: SvgPicture.asset('assets/svg/parking.svg'),
    ),
    StateModel(
      action: 'Загрузка груза',
      imagePath: SvgPicture.asset('assets/svg/load.svg'),
    ),
    StateModel(
      action: 'Выгрузка груза',
      imagePath: SvgPicture.asset('assets/svg/unload.svg'),
    ),
    StateModel(
      action: 'Доставлен',
      imagePath: SvgPicture.asset('assets/svg/delivery.svg'),
    ),
  ];

  static SvgPicture getImageState(String action) {
    try {
      return stateList.firstWhere((state) => state.action == action).imagePath;
    } catch (e) {
      return accountUnknownImage;
    }
  }
}
