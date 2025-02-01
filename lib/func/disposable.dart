typedef DisposableValue<T> = T? Function();
DisposableValue<T> disposableValue<T>(T value) {
  var used = false;
  return () {
    if (used) {
      return null;
    }
    used = true;
    return value;
  };
}
