class Credentials {
  final Map<String, dynamic> credentials;

  Credentials(this.credentials) {
    if (credentials.isEmpty) {
      throw Exception('Credentials should not empty.');
    }

    if (!credentials.containsKey('consumer_key')) {
      throw Exception('Credentials must include consumer_key.');
    }

    if (!credentials.containsKey('consumer_secret')) {
      throw Exception('Credentials must include consumer_secret.');
    }

    if (!credentials.containsKey('token')) {
      throw Exception('Credentials must include token.');
    }

    if (!credentials.containsKey('token_secret')) {
      throw Exception('Credentials must include token_secret.');
    }
  }

  get consumerKey => credentials['consumer_key'];

  get consumerSecret => credentials['consumer_secret'];

  get tokenKey => credentials['token'];

  get tokenSecret => credentials['token_secret'];
}
