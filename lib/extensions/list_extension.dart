extension ListExtension<T> on List<T> {
  List<T> whereIndexed(bool Function(T element, int index) test) {
    List<T> result = [];
    for (var i = 0; i < length; i++) {
      if (test(this[i], i)) result.add(this[i]);
    }
    return result;
  }

  bool everyIndexed(bool Function(T element, int index) test) {
    for (var i = 0; i < length; i++) {
      if (!test(this[i], i)) return false;
    }
    return true;
  }
}
