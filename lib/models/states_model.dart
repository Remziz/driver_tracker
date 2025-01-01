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
      imagePath: SvgPicture.asset('assets/svg/Repair.svg'),
    ),
    StateModel(
      action: 'На парковке',
      imagePath: SvgPicture.asset('assets/svg/Parking.svg'),
    ),
    StateModel(
      action: 'Загрузка груза',
      imagePath: SvgPicture.asset('assets/svg/Load.svg'),
    ),
    StateModel(
      action: 'Выгрузка груза',
      imagePath: SvgPicture.asset('assets/svg/Unload.svg'),
    ),
    StateModel(
      action: 'Доставлен',
      imagePath: SvgPicture.asset('assets/svg/Delivery.svg'),
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
