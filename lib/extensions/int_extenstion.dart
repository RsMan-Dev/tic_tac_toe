import 'dart:math';

extension IntExtension on int {
  Point<int> getXAndY(int size) {
    return Point(this % size, this ~/ size);
  }

  // -1 means at extreme left, 1 means at extreme right
  // 0 means at center, 0.5 means at center right
  // assuming this starts at 0
  double xForce(int size) => (this - ((size - 1) / 2)) / ((size - 1) / 2);

  // -1 means at extreme top, 1 means at extreme bottom
  // 0 means at center, 0.5 means at center bottom
  // assuming this starts at 0
  double yForce(int size) => (this - ((size - 1) / 2)) / ((size - 1) / 2);
}

extension NumExtension on num {
  double get degreesToRadians => this * pi / 180;
}
