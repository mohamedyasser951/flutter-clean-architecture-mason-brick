import 'package:elmohandes_client/core/util/api_base_helper.dart';
{% if cubit_type == 'pagination' -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% else -%}
{% if response_model_name == 'StatusResponse' -%}
import 'package:elmohandes_client/core/entities/status_response.dart';
{% else -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% endif -%}
{% endif -%}

abstract class {{feature_name|titleCase}}RemoteDataSource {
{% if cubit_type == 'pagination' -%}
  Future<{{response_model_name}}> get{{feature_name|titleCase}}({
    required int page,
    String? searchText,
    String token,
  });
{% else -%}
{% if http_method == 'GET' -%}
  Future<{{response_model_name}}> get{{feature_name|titleCase}}({String token});
{% elif http_method == 'POST' -%}
  Future<{{response_model_name}}> create{{feature_name|titleCase}}({
    required Map<String, dynamic> body,
    String token,
  });
{% elif http_method == 'PUT' -%}
  Future<{{response_model_name}}> update{{feature_name|titleCase}}({
    required int id,
    required Map<String, dynamic> body,
    String token,
  });
{% elif http_method == 'DELETE' -%}
  Future<{{response_model_name}}> delete{{feature_name|titleCase}}({
    required int id,
    String token,
  });
{% endif -%}
{% endif -%}
}

{% if cubit_type == 'pagination' -%}
const String get{{feature_name|titleCase}}API = '{{api_endpoint}}';
{% else -%}
const String {{feature_name}}API = '{{api_endpoint}}';
{% endif -%}

class {{feature_name|titleCase}}RemoteDataSourceImpl implements {{feature_name|titleCase}}RemoteDataSource {
  final ApiBaseHelper apiBaseHelper;

  {{feature_name|titleCase}}RemoteDataSourceImpl({required this.apiBaseHelper});

{% if cubit_type == 'pagination' -%}
  @override
  Future<{{response_model_name}}> get{{feature_name|titleCase}}({
    required int page,
    String? searchText,
    required String token,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {'page': page};
      if (searchText != null && searchText.isNotEmpty) {
        queryParams['search'] = searchText;
      }
      
      final response = await apiBaseHelper.get(
        url: get{{feature_name|titleCase}}API,
        token: token,
        queryParameters: queryParams,
      );
      return {{response_model_name}}.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
{% else -%}
{% if http_method == 'GET' -%}
  @override
  Future<{{response_model_name}}> get{{feature_name|titleCase}}({required String token}) async {
    try {
      final response = await apiBaseHelper.get(
        url: {{feature_name}}API,
        token: token,
      );
      return {{response_model_name}}.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
{% elif http_method == 'POST' -%}
  @override
  Future<{{response_model_name}}> create{{feature_name|titleCase}}({
    required Map<String, dynamic> body,
    required String token,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: {{feature_name}}API,
        body: body,
        token: token,
      );
      return {{response_model_name}}.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
{% elif http_method == 'PUT' -%}
  @override
  Future<{{response_model_name}}> update{{feature_name|titleCase}}({
    required int id,
    required Map<String, dynamic> body,
    required String token,
  }) async {
    try {
      final response = await apiBaseHelper.post(
        url: '${{feature_name}}API/$id',
        body: body,
        token: token,
      );
      return {{response_model_name}}.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
{% elif http_method == 'DELETE' -%}
  @override
  Future<{{response_model_name}}> delete{{feature_name|titleCase}}({
    required int id,
    required String token,
  }) async {
    try {
      final response = await apiBaseHelper.delete(
        url: '${{feature_name}}API/$id',
        token: token,
      );
      return {{response_model_name}}.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
{% endif -%}
{% endif -%}
}
