import 'package:http/http.dart' as http;
import 'package:netsuite_connector/src/credentials.dart';
import 'package:netsuite_connector/src/enum/signature_method.dart';
import 'package:netsuite_connector/src/handlers/request_handler.dart';
import 'package:netsuite_connector/src/signature.dart';

class OAuthHandler extends RequestHandler {
  final String version = '1.0';
  final Credentials credentials;
  final SignatureMethod hash;

  OAuthHandler(
      {required this.credentials, this.hash = SignatureMethod.HMAC_SHA256});

  @override
  http.BaseRequest handle(http.BaseRequest request) {
    Map<String, String> queryParams = query(request.url);

    String url = baseUri(request.url);
    Map<String, String> authHeader = header();
    Map<String, String> baseHeaders = combine(queryParams, authHeader);

    String queryStr = queryString(sort(baseHeaders));

    String signatureBaseString =
        [request.method, encode(url), encode(queryStr)].join('&');

    Signature signature = Signature(credentials, method: hash);
    authHeader['oauth_signature'] = signature.hash(signatureBaseString);

    var headerString = build({}
      ..addAll({'realm': account(request.url)})
      ..addAll(authHeader));

    Map<String, String> requestHeaders = {
      'Authorization': headerString,
      'Content-type': 'application/json',
    };

    request.headers.addAll(requestHeaders);
    return request;
  }

  Map<String, String> header() {
    return {
      'oauth_consumer_key': credentials.consumerKey,
      'oauth_nonce': nonce(),
      'oauth_signature_method': hash.key,
      'oauth_timestamp': timestamp(),
      'oauth_token': credentials.tokenKey,
      'oauth_version': version
    };
  }

  String build(Map<String, String> headers) {
    var str = 'OAuth ';
    headers.forEach((key, value) {
      str += '$key="${encode(value)}", ';
    });

    return str.substring(0, str.length - 2);
  }
}
