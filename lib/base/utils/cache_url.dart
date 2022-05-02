

extension CacheKey on String? {
  String? get cacheKey {
    if (this == null) { return null; }
    final uri = Uri.parse(this ?? "");
    final queryMap = uri.queryParameters;
    var query = "";
    if (queryMap.containsKey('x-oss-process')) {
      query = ('?x-oss-process=${queryMap['x-oss-process']}');
    }
    return uri.scheme + '://'+ uri.host + uri.path + query;
  }
}