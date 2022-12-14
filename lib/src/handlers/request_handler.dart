import 'dart:math';

import 'package:http/http.dart' as http;

abstract class RequestHandler {
  late final http.BaseRequest request;

  http.BaseRequest handle(http.BaseRequest request);

  Map<String, String> query(Uri uri) {
    return Uri.splitQueryString(uri.query);
  }

  String baseUri(Uri uri) {
    return Uri(host: uri.host, scheme: uri.scheme, path: uri.path).toString();
  }

  String nonce({int length = 32}) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  String timestamp() {
    var millisecondsSinceEpoch = DateTime.now().toUtc().millisecondsSinceEpoch;
    var timeStamp = (millisecondsSinceEpoch / 1000).round();

    return timeStamp.toString();
  }

  String encode(String str) {
    return Uri.encodeComponent(str);
  }

  String account(Uri uri) {
    return uri.host.split('.')[0].replaceAll('-', '_').toUpperCase();
  }

  Map<String, String> sort(Map<String, String> map) {
    return Map.fromEntries(
        map.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
  }

  Map<String, String> combine(
      Map<String, String> map1, Map<String, String> map2) {
    return map1..addAll(map2);
  }

  String queryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';

    params.forEach((key, value) {
      if (inRecursion) {
        key = '[$key]';
      }

      if (value is String || value is int || value is double || value is bool) {
        query += '$prefix$key=$value';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              queryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return filterQueryString(query.substring(1));
  }

  String filterQueryString(String string) {
    return string
        .replaceAll('!', "%21")
        .replaceAll('*', "%2A")
        .replaceAll('\'', "%27")
        .replaceAll('/', "%2F")
        .replaceAll('\\', "%5C")
        .replaceAll('(', "%28")
        .replaceAll(')', "%29")
        .replaceAll(',', "%2C")
        .replaceAll(':', "%3A");
  }
}
