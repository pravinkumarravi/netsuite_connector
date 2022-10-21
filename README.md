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

## Features

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

<!-- TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. -->

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

  var request = {'script': '215', 'deploy': '1'};
  await client.get(baseUri.replace(queryParameters: request)).then((res) => print(res.body));
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
