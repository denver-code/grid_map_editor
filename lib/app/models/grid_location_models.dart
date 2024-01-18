class Location {
  final int x;
  final int y;
  final String item;

  Location({required this.item, required this.x, required this.y});

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'x': x,
      'y': y,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      item: json['item'],
      x: json['x'],
      y: json['y'],
    );
  }
}

class Coordinate {
  final int x;
  final int y;

  Coordinate({required this.x, required this.y});
}
