import 'package:dartz/dartz.dart';
import 'package:elmohandes_client/core/error/failures.dart';
{% if cubit_type == 'pagination' -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% else -%}
{% if response_model_name == 'StatusResponse' -%}
import 'package:elmohandes_client/core/entities/status_response.dart';
{% else -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% endif -%}
{% endif -%}

abstract class {{feature_name|titleCase}}Repository {
{% if cubit_type == 'pagination' -%}
  Future<Either<Failure, {{response_model_name}}>> get{{feature_name|titleCase}}({
    required int page,
    String? searchText,
  });
{% else -%}
{% if http_method == 'GET' -%}
  Future<Either<Failure, {{response_model_name}}>> get{{feature_name|titleCase}}();
{% elif http_method == 'POST' -%}
  Future<Either<Failure, {{response_model_name}}>> create{{feature_name|titleCase}}(
    Map<String, dynamic> body,
  );
{% elif http_method == 'PUT' -%}
  Future<Either<Failure, {{response_model_name}}>> update{{feature_name|titleCase}}({
    required int id,
    required Map<String, dynamic> body,
  });
{% elif http_method == 'DELETE' -%}
  Future<Either<Failure, {{response_model_name}}>> delete{{feature_name|titleCase}}(int id);
{% endif -%}
{% endif -%}
}
