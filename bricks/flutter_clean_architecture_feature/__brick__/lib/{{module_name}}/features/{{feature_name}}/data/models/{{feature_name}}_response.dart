{% if cubit_type == 'pagination' -%}
import 'package:elmohandes_client/core/entities/pagination_response.dart';

class {{response_model_name}} extends PaginationResponse {
  {{response_model_name}}({
    required this.data,
    required super.links,
    required super.meta,
    required super.status,
  });

  final List<{{data_model_name}}> data;

  factory {{response_model_name}}.fromJson(Map<String, dynamic> json) {
    return {{response_model_name}}(
      data: json["data"] == null
          ? []
          : List<{{data_model_name}}>.from(
            json["data"]!.map((x) => {{data_model_name}}.fromJson(x)),
          ),
      links: Links.fromJson(json["links"]),
      meta: Meta.fromJson(json["meta"]),
      status: json["status"],
    );
  }
}
{% else -%}
{% if response_model_name == 'StatusResponse' -%}
// Using core StatusResponse - no need to create a new model
{% else -%}
class {{response_model_name}} {
  {{response_model_name}}({
    required this.data,
    required this.status,
  });

  final {{data_model_name}} data;
  final int status;

  factory {{response_model_name}}.fromJson(Map<String, dynamic> json) {
    return {{response_model_name}}(
      data: {{data_model_name}}.fromJson(json["data"]),
      status: json["status"],
    );
  }
}
{% endif -%}
{% endif -%}

class {{data_model_name}} {
  {{data_model_name}}({
    required this.id,
    // Add your specific fields here
    required this.name,
    required this.description,
  });

  final int id;
  final String name;
  final String description;

  factory {{data_model_name}}.fromJson(Map<String, dynamic> json) {
    return {{data_model_name}}(
      id: json["id"],
      name: json["name"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
    };
  }
}
