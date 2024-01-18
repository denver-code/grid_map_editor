import 'package:grid_map_editor/app/models/grid_location_models.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxMap<int, Location> savedLocations = <int, Location>{}.obs;
  List<String> items = <String>[
    'Road',
    'House',
    'Tree',
    'Water',
    'Clear',
  ];

  RxString selectedItem = 'Clear'.obs;
  Rx<Coordinate> hoveredCoordinate = Coordinate(x: 0, y: 0).obs;

  exportMap() {
    Map<String, dynamic> map = {};
    savedLocations.forEach((key, value) {
      map['${value.x}_${value.y}'] = value.toJson();
    });
    String jsonString = map.toString();
  }
}
