import 'package:flutter_svg/svg.dart';
import 'package:vehical_app/design/images.dart';

class TransportImageModel {
  final String modelName;
  final SvgPicture imagePath;

  TransportImageModel({
    required this.modelName,
    required this.imagePath,
  });

  static List<TransportImageModel> transportImageList = [
    TransportImageModel(
      modelName: 'Мотоцикл',
      imagePath: SvgPicture.asset('assets/svg/motorcycle.svg'),
    ),
    TransportImageModel(
      modelName: 'Гольф-кар',
      imagePath: SvgPicture.asset('assets/svg/Tuktuk.svg'),
    ),
    TransportImageModel(
      modelName: 'Легковая машина',
      imagePath: SvgPicture.asset('assets/svg/Car.svg'),
    ),
    TransportImageModel(
      modelName: 'Автобус',
      imagePath: SvgPicture.asset('assets/svg/Bus.svg'),
    ),
    TransportImageModel(
      modelName: 'Грузовик',
      imagePath: SvgPicture.asset(
        'assets/svg/Truck.svg',
      ),
    ),
  ];

  static List<TransportImageModel> transportImageAddList = [
    TransportImageModel(
      modelName: 'Мотоцикл',
      imagePath: SvgPicture.asset(
        'assets/svg/motorcycle.svg',
        height: 100,
        width: 60,
      ),
    ),
    TransportImageModel(
      modelName: 'Гольф-кар',
      imagePath: SvgPicture.asset(
        'assets/svg/Tuktuk.svg',
        height: 100,
        width: 60,
      ),
    ),
    TransportImageModel(
      modelName: 'Легковая машина',
      imagePath: SvgPicture.asset(
        'assets/svg/Car.svg',
        height: 100,
        width: 60,
      ),
    ),
    TransportImageModel(
      modelName: 'Автобус',
      imagePath: SvgPicture.asset(
        'assets/svg/Bus.svg',
        height: 100,
        width: 60,
      ),
    ),
    TransportImageModel(
      modelName: 'Грузовик',
      imagePath: SvgPicture.asset(
        'assets/svg/Truck.svg',
        height: 100,
        width: 60,
      ),
    ),
  ];

  static SvgPicture getImageTransport(String modelName) {
    try {
      return transportImageList
          .firstWhere((list) => list.modelName == modelName)
          .imagePath;
    } catch (e) {
      return accountUnknownImage;
    }
  }

  static SvgPicture getImageAddTransport(String modelName) {
    try {
      return transportImageAddList
          .firstWhere((list) => list.modelName == modelName)
          .imagePath;
    } catch (e) {
      return accountUnknownImage;
    }
  }
}
