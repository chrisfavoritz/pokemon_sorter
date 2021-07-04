import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonListing {
  final int id;
  final String name;

  PokemonListing({required this.id, required this.name});

  factory PokemonListing.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);
return PokemonListing(id: id, name: name);
  }
}

class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse({required this.pokemonListings, required this.canLoadNextPage});

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['result'] as List).map((listingJson) => PokemonListing.fromJson(listingJson)).toList();
    return PokemonPageResponse(pokemonListings: pokemonListings, canLoadNextPage: canLoadNextPage);
  }
}

class Data {


  final client = http.Client();
  final baseUrl = 'pokeapi.co';

  //final Uri uri = 'https://pokeapi.co/api/v2/pokemon/1' as Uri;

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    final queryParameters = {'limit': '150', 'offset': pageIndex * 150};
    final uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonPageResponse.fromJson(json);
  }

Future getData(int id) async {
    http.Response response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

      String data = response.body;

      var decodedData = jsonDecode(data);
    return decodedData;

  }
}