import 'package:netsuite_connector/netsuite_connector.dart';

void main() async {
  const Map<String, String> oauthCredentials = {
    'consumer_key': 'your consumer_key',
    'consumer_secret': 'your consumer_secret',
    'token': 'your token',
    'token_secret': 'your token_secret',
  };

  Uri baseUri = Uri.parse(
      'https://<ACCOUNT_ID>.restlets.api.netsuite.com/app/site/hosting/restlet.nl');

  Credentials credentials = Credentials(oauthCredentials);
  RequestHandler handler = OAuthHandler(credentials: credentials);
  NetsuiteClient client = NetsuiteClient(handler: handler);

  var request = {'script': '215', 'deploy': '1'};
  await client
      .get(baseUri.replace(queryParameters: request))
      .then((value) => print(value.body));
}
