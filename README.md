# Flutter Clean Architecture Mason Brick

A comprehensive Mason brick for generating Flutter features following clean architecture principles with Cubit state management.

## 🚀 Features

- ✅ **Clean Architecture** (Data, Domain, Presentation layers)
- ✅ **Cubit State Management** with two patterns:
  - **Pagination Cubit**: For list features with infinite scroll and filtering
  - **Simple Cubit**: For basic CRUD operations (GET, POST, PUT, DELETE)
- ✅ **Dependency Injection** with GetIt
- ✅ **Error Handling** with Either<Failure, Success>
- ✅ **API Integration** with Dio
- ✅ **Authentication Support**
- ✅ **Repository Pattern**
- ✅ **Use Case Pattern**

## 📦 Installation

### 1. Install Mason CLI
```bash
dart pub global activate mason_cli
```

### 2. Add this brick to your project

**From GitHub:**
```bash
mason add flutter_clean_architecture_feature --git https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git
```

**From Local Path:**
```bash
mason add flutter_clean_architecture_feature --path ./mason_template/bricks/flutter_clean_architecture_feature
```

### 3. Generate a new feature
```bash
mason make flutter_clean_architecture_feature
```

## ⚙️ Configuration Options

| Option | Description | Example Values | Default |
|--------|-------------|----------------|---------|
| `feature_name` | The name of the feature | `user_profile`, `product_list`, `orders` | `sample_feature` |
| `module_name` | The module/domain name | `merchants`, `employees`, `core_features` | `sample_module` |
| `cubit_type` | Type of cubit pattern | `pagination`, `simple` | `pagination` |
| `response_model_name` | The name of the response model | `UserResponse`, `ProductResponse`, `StatusResponse` | `SampleResponse` |
| `data_model_name` | The name of the data model | `User`, `Product`, `Order` | `SampleData` |
| `use_case_name` | The name of the use case | `GetUser`, `CreateProduct`, `DeleteOrder` | `GetSample` |
| `cubit_name` | The name of the cubit | `UserCubit`, `ProductCubit`, `OrderCubit` | `SampleCubit` |
| `api_endpoint` | The API endpoint for this feature | `/users`, `/products`, `/orders` | `/samples` |
| `http_method` | The HTTP method for the API call | `GET`, `POST`, `PUT`, `DELETE` | `GET` |
| `requires_auth` | Whether this feature requires authentication | `true`, `false` | `true` |

## 📁 Generated Structure

```
lib/
└── {{module_name}}/
    └── features/
        └── {{feature_name}}/
            ├── data/
            │   ├── datasources/
            │   │   └── {{feature_name}}_remote_data_source.dart
            │   ├── models/
            │   │   └── {{feature_name}}_response.dart
            │   └── repositories/
            │       └── {{feature_name}}_repository_impl.dart
            ├── domain/
            │   ├── repositories/
            │   │   └── {{feature_name}}_repository.dart
            │   └── usecases/
            │       └── {{use_case_name}}_usecase.dart
            └── presentation/
                └── cubit/
                    ├── {{cubit_name}}_cubit.dart
                    └── {{cubit_name}}_state.dart
```

## 🎯 Cubit Patterns

### 1. Pagination Cubit
Perfect for list features with infinite scroll and filtering:

**Features:**
- `get{{feature_name|titleCase}}ForFirstTime()` - Load first page
- `loadMore{{feature_name|titleCase}}()` - Load more items
- `setFilter()` - Apply filters with debouncing
- `resetFilters()` - Clear all filters
- `initScroll()` - Initialize scroll controller for infinite scroll

**State Properties:**
- `allRequestStatus` - Status for initial load
- `paginationRequestStatus` - Status for pagination
- `{{feature_name}}` - List of items
- `currentPage` - Current page number
- `lastPage` - Last page number
- `searchText` - Search filter

### 2. Simple Cubit
Perfect for basic CRUD operations:

**Features:**
- `get{{feature_name|titleCase}}()` - GET request
- `create{{feature_name|titleCase}}()` - POST request
- `update{{feature_name|titleCase}}()` - PUT request
- `delete{{feature_name|titleCase}}()` - DELETE request

**State Classes:**
- `{{cubit_name}}Initial` - Initial state
- `{{cubit_name}}Loading` - Loading state
- `{{cubit_name}}Loaded` - Success state with data
- `{{cubit_name}}Error` - Error state with message

## 💡 Examples

### Example 1: Products List (Pagination)
```bash
mason make flutter_clean_architecture_feature
# feature_name: products
# module_name: merchants
# cubit_type: pagination
# response_model_name: ProductResponse
# data_model_name: Product
# use_case_name: GetAllProducts
# cubit_name: ProductsCubit
# api_endpoint: /products
# http_method: GET
# requires_auth: true
```

### Example 2: Create User (Simple POST)
```bash
mason make flutter_clean_architecture_feature
# feature_name: create_user
# module_name: core_features
# cubit_type: simple
# response_model_name: StatusResponse
# data_model_name: User
# use_case_name: CreateUser
# cubit_name: CreateUserCubit
# api_endpoint: /users
# http_method: POST
# requires_auth: true
```

### Example 3: Delete Item (Simple DELETE)
```bash
mason make flutter_clean_architecture_feature
# feature_name: delete_item
# module_name: merchants
# cubit_type: simple
# response_model_name: StatusResponse
# data_model_name: Item
# use_case_name: DeleteItem
# cubit_name: DeleteItemCubit
# api_endpoint: /items
# http_method: DELETE
# requires_auth: true
```

## 🔧 Integration

### 1. Add to Injection Container
```dart
// In lib/injection_container.dart
import 'package:your_app/{{module_name}}/features/{{feature_name}}/{{feature_name}}_injection.dart';

// In ServiceLocator.init()
init{{feature_name|titleCase}}Injection();

// In globalBlocProviders
...{{feature_name|snakeCase}}Blocs(),
```

### 2. Use in UI

#### Pagination Cubit Usage:
```dart
// Initialize
context.read<{{cubit_name}}>().initScroll();

// Load first page
context.read<{{cubit_name}}>().get{{feature_name|titleCase}}ForFirstTime();

// Apply filter
context.read<{{cubit_name}}>().setFilter(searchText: 'search query');
```

#### Simple Cubit Usage:
```dart
// GET request
context.read<{{cubit_name}}>().get{{feature_name|titleCase}}();

// POST request
context.read<{{cubit_name}}>().create{{feature_name|titleCase}}({
  'name': 'New Item',
  'description': 'Item description',
});
```

## 🛠️ Customization

### 1. Modify Response Models
Update the `{{data_model_name}}` class to match your API structure:

```dart
class {{data_model_name}} {
  {{data_model_name}}({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  final int id;
  final String name;
  final String email;
  final String phone;

  // ... fromJson and toJson methods
}
```

### 2. Add Additional Filters
For pagination cubits, add more filter parameters:

```dart
void setFilter({
  String? searchText,
  int? categoryId,
  String? status,
}) {
  // Implementation
}
```

## 📋 Dependencies

This template assumes your project has these dependencies:
- `dartz` - For Either type
- `equatable` - For state equality
- `flutter_bloc` - For Cubit state management
- `get_it` - For dependency injection
- `dio` - For HTTP requests

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 🔗 Links

- [Mason Documentation](https://docs.brickhub.dev/)
- [Flutter Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Bloc State Management](https://bloclibrary.dev/)

---

Made with ❤️ for the Flutter community
