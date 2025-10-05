import 'package:dartz/dartz.dart';
import 'package:elmohandes_client/core/error/exceptions.dart';
import 'package:elmohandes_client/core/error/failures.dart';
{% if requires_auth -%}
import 'package:elmohandes_client/core_features/auth/data/datasources/auth_local_datasource.dart';
{% endif -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/datasources/{{feature_name}}_remote_data_source.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/domain/repositories/{{feature_name}}_repository.dart';
{% if cubit_type == 'pagination' -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% else -%}
{% if response_model_name == 'StatusResponse' -%}
import 'package:elmohandes_client/core/entities/status_response.dart';
{% else -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% endif -%}
{% endif -%}

class {{feature_name|titleCase}}RepositoryImpl implements {{feature_name|titleCase}}Repository {
  final {{feature_name|titleCase}}RemoteDataSource {{feature_name}}RemoteDataSource;
{% if requires_auth -%}
  final AuthLocalDataSource authLocalDataSource;
{% endif -%}

  {{feature_name|titleCase}}RepositoryImpl({
    required this.{{feature_name}}RemoteDataSource,
{% if requires_auth -%}
    required this.authLocalDataSource,
{% endif -%}
  });

{% if cubit_type == 'pagination' -%}
  @override
  Future<Either<Failure, {{response_model_name}}>> get{{feature_name|titleCase}}({
    required int page,
    String? searchText,
  }) async {
    try {
{% if requires_auth -%}
      final String token = await authLocalDataSource.getCacheUserAccessToken();
{% else -%}
      final String token = '';
{% endif -%}
      return right(
        await {{feature_name}}RemoteDataSource.get{{feature_name|titleCase}}(
          page: page,
          searchText: searchText,
          token: token,
        ),
      );
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
{% else -%}
{% if http_method == 'GET' -%}
  @override
  Future<Either<Failure, {{response_model_name}}>> get{{feature_name|titleCase}}() async {
    try {
{% if requires_auth -%}
      final String token = await authLocalDataSource.getCacheUserAccessToken();
{% else -%}
      final String token = '';
{% endif -%}
      return right(
        await {{feature_name}}RemoteDataSource.get{{feature_name|titleCase}}(token: token),
      );
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
{% elif http_method == 'POST' -%}
  @override
  Future<Either<Failure, {{response_model_name}}>> create{{feature_name|titleCase}}(
    Map<String, dynamic> body,
  ) async {
    try {
{% if requires_auth -%}
      final String token = await authLocalDataSource.getCacheUserAccessToken();
{% else -%}
      final String token = '';
{% endif -%}
      return right(
        await {{feature_name}}RemoteDataSource.create{{feature_name|titleCase}}(
          body: body,
          token: token,
        ),
      );
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
{% elif http_method == 'PUT' -%}
  @override
  Future<Either<Failure, {{response_model_name}}>> update{{feature_name|titleCase}}({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    try {
{% if requires_auth -%}
      final String token = await authLocalDataSource.getCacheUserAccessToken();
{% else -%}
      final String token = '';
{% endif -%}
      return right(
        await {{feature_name}}RemoteDataSource.update{{feature_name|titleCase}}(
          id: id,
          body: body,
          token: token,
        ),
      );
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
{% elif http_method == 'DELETE' -%}
  @override
  Future<Either<Failure, {{response_model_name}}>> delete{{feature_name|titleCase}}(int id) async {
    try {
{% if requires_auth -%}
      final String token = await authLocalDataSource.getCacheUserAccessToken();
{% else -%}
      final String token = '';
{% endif -%}
      return right(
        await {{feature_name}}RemoteDataSource.delete{{feature_name|titleCase}}(
          id: id,
          token: token,
        ),
      );
    } on ServerException catch (error) {
      return left(ServerFailure.formServerException(error));
    }
  }
{% endif -%}
{% endif -%}
}
