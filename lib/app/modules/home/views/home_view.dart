import 'package:grid_map_editor/app/models/grid_location_models.dart';
import 'package:grid_map_editor/app/modules/home/controllers/home_controller.dart';
import 'package:grid_map_editor/app/components/two_dimentional_grid.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                TwoDimensionalGridView(
                  diagonalDragBehavior: DiagonalDragBehavior.free,
                  delegate: TwoDimensionalChildBuilderDelegate(
                    maxXIndex: 9,
                    maxYIndex: 9,
                    builder: (BuildContext context, ChildVicinity vicinity) {
                      return Obx(
                        () => MouseRegion(
                          onEnter: (PointerEnterEvent event) {
                            controller.hoveredCoordinate.value = Coordinate(
                                x: vicinity.xIndex, y: vicinity.yIndex);
                          },
                          child: GestureDetector(
                            onTap: () {
                              if (controller.selectedItem.value == 'Clear') {
                                controller.savedLocations.remove(
                                    vicinity.xIndex * 10 + vicinity.yIndex);
                              } else {
                                controller.savedLocations[vicinity.xIndex * 10 +
                                    vicinity.yIndex] = Location(
                                  item: controller.selectedItem.value,
                                  x: vicinity.xIndex,
                                  y: vicinity.yIndex,
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              height: 200,
                              width: 200,
                              child: Center(
                                child: Text(
                                  controller.savedLocations.containsKey(
                                          vicinity.xIndex * 10 +
                                              vicinity.yIndex)
                                      ? controller
                                          .savedLocations[vicinity.xIndex * 10 +
                                              vicinity.yIndex]!
                                          .item
                                      : 'Terrain',
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Obx(
                  () => Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.black),
                      child: Center(
                        child: Text(
                          '${controller.savedLocations.containsKey(controller.hoveredCoordinate.value.x * 10 + controller.hoveredCoordinate.value.y) ? controller.savedLocations[controller.hoveredCoordinate.value.x * 10 + controller.hoveredCoordinate.value.y]!.item : 'Terrain'} (${controller.hoveredCoordinate.value.x}, ${controller.hoveredCoordinate.value.y})',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                width: controller.items.length * 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          controller.selectedItem.value =
                              controller.items[index];
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.selectedItem.value ==
                                    controller.items[index]
                                ? Colors.black
                                : Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          height: 100,
                          width: 100,
                          child: Center(
                            child: Text(
                              controller.items[index],
                              style: TextStyle(
                                color: controller.selectedItem.value ==
                                        controller.items[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.exportMap();
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
