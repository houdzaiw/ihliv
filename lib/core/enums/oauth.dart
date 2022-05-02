
enum OauthType {
  facebook, google, apple, guest, anchor
}

extension OauthTypeExtension on OauthType {
  int rawValue() {
    switch (this) {
      case OauthType.facebook: return 1;
      case OauthType.google: return 2;
      case OauthType.apple: return 3;
      case OauthType.guest: return 4;
      case OauthType.anchor: return 20;
    }
  }
}