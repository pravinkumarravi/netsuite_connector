<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# NetsuiteConnector

A module which makes connecting to Netsuite RESTlets using OAuth much easier.

## Example

# Installing:

With Dart:

```bash
dart pub add netsuite_connector
```

This will add a line like this to your package's pubspec.yaml (and run an implicit dart pub get):

```yaml
dependencies:
  netsuite_connector: ^1.0.4
```

Now in your Dart code, you can use:

```dart
import 'package:netsuite_connector/netsuite_connector.dart';
```

## Usage

```dart
  const Map<String, String> oauthCredentials = {
    'consumer_key': 'your consumer_key',
    'consumer_secret': 'your consumer_secret',
    'token': 'your token',
    'token_secret': 'your token_secret',
  };

  Uri baseUri = Uri.parse('https://<ACCOUNT_ID>.restlets.api.netsuite.com/app/site/hosting/restlet.nl');

  Credentials credentials = Credentials(oauthCredentials);
  RequestHandler handler = OAuthHandler(credentials: credentials);
  NetsuiteClient client = NetsuiteClient(handler: handler);
```

Optionally you may change signature method any of following HMAC-SHA1, HMAC-SHA256, HMAC-SHA384, HMAC-SHA512

```dart
RequestHandler handler = OAuthHandler(credentials: credentials, hash: SignatureMethod.HMAC_SHA256);
```

# GET

```dart
  var getReq = {'script': '100', 'deploy': '1', 'id': '1'};
  await client.get(baseUri.replace(queryParameters: getReq))
      .then((res) => print(res.body));
```

# POST

```dart
  var payload = {"id": 2, "title": "example", "body": "lorem ipsum"};
  var postReq = {'script': '101', 'deploy': '1'};
  await client.post(baseUri.replace(queryParameters: postReq),body: payload)
      .then((res) => print(res.body));
```

# DELETE

```dart
  var delReq = {'script': '102', 'deploy': '1', 'id': '1'};
  await client.delete(baseUri.replace(queryParameters: delReq))
      .then((res) => print(res.body));
```

## Getting started

I built this OAuth1.0 package for netsuite
This is the <http.BaseClient> implementation of OAuth 1.0 for Restlet API.
