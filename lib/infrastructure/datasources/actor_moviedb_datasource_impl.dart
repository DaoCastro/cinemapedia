import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credit_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/enviroment.dart';

class ActorMovieDbDataSourceImpl extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: Enviroment.theBaseUrlMovieDb,
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieid) async {
    final response = await dio.get('/movie/$movieid/credits');

    if (response.statusCode != 200) {
      throw Exception('Movie with id : $movieid not found');
    }

    final credit = CreditResponse.fromJson(response.data);
    final actors = credit.cast
        .map((castMoviedb) => ActorMapper.castToEntitie(castMoviedb))
        .toList();

    return actors;
  }
}
