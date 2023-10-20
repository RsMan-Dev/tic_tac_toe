extension ListExtension<T> on List<T> {
  // inspired from ruby's filter with index
  List<T> whereIndexed(bool Function(T element, int index) test) {
    List<T> result = [];
    for (var i = 0; i < length; i++) {
      if (test(this[i], i)) result.add(this[i]);
    }
    return result;
  }

  // inspired from ruby's all? with index, to avoid using 2 loops
  bool everyIndexed(bool Function(T element, int index) test) {
    for (var i = 0; i < length; i++) {
      if (!test(this[i], i)) return false;
    }
    return true;
  }
}
