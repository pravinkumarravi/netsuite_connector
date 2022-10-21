import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:netsuite_connector/src/credentials.dart';
import 'package:netsuite_connector/src/enum/signature_method.dart';

class Signature {
  final Credentials credentials;
  final SignatureMethod method;

  Signature(this.credentials, {this.method = SignatureMethod.HMAC_SHA256});

  String hash(String message) {
    List<int> bytes = utf8.encode(message);
    List<int> secret =
        utf8.encode('${credentials.consumerSecret}&${credentials.tokenSecret}');

    Hmac hmacSha256 = Hmac(method.value, secret);
    Digest digest = hmacSha256.convert(bytes);

    return base64Encode(digest.bytes);
  }
}
