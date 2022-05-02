enum UpdateUserMediaType { add, update, remove }

extension UpdateUserMediaTypeExt on UpdateUserMediaType {
  int get value  {
    switch (this) {
      case UpdateUserMediaType.add: return 1;
      case UpdateUserMediaType.update: return 2;
      case UpdateUserMediaType.remove: return 3;
    }
  }
}
