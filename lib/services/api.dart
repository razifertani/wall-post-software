import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swapi_dev/models/apiResultModel.dart';

Future<Either<Exception, ApiResult>> getSpecies({required String link}) async {
  try {
    final getSpeciesResponse = await http.get(Uri.parse(link));

    if (getSpeciesResponse.statusCode == 200) {
      ApiResult apiResult = ApiResult.fromJson(json.decode(getSpeciesResponse.body));

      return Right(apiResult);
    } else {
      return Left(Exception());
    }
  } catch (e) {
    print(e);
    return Left(Exception());
  }
}
