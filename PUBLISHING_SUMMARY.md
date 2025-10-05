# 🚀 Complete Guide: Publishing Flutter Clean Architecture Mason Brick

## ✅ What You Have Now

You now have a complete Mason brick template for Flutter clean architecture with Cubit state management. Here's what's been created:

### 📁 Current Structure
```
mason_template/
├── bricks/
│   └── flutter_clean_architecture_feature/
│       └── __brick__/
│           ├── brick.yaml ✅
│           └── lib/ ✅
│               └── {{module_name}}/
│                   └── features/
│                       └── {{feature_name}}/
│                           ├── data/
│                           │   ├── datasources/ ✅
│                           │   ├── models/ ✅
│                           │   └── repositories/ ✅
│                           ├── domain/
│                           │   ├── repositories/ ✅
│                           │   └── usecases/ ✅
│                           └── presentation/
│                               └── cubit/ ✅
├── README.md ✅
├── GITHUB_PUBLISHING_GUIDE.md ✅
└── PUBLISHING_SUMMARY.md ✅
```

## 🎯 Next Steps to Publish

### Step 1: Create Missing Template Files

You need to create these remaining template files:

#### 1. Use Case Template
```bash
# Create the file
touch mason_template/bricks/flutter_clean_architecture_feature/__brick__/lib/{{module_name}}/features/{{feature_name}}/domain/usecases/{{use_case_name|snakeCase}}_usecase.dart
```

#### 2. Cubit Template
```bash
# Create the file
touch mason_template/bricks/flutter_clean_architecture_feature/__brick__/lib/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_cubit.dart
```

#### 3. State Template
```bash
# Create the file
touch mason_template/bricks/flutter_clean_architecture_feature/__brick__/lib/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_state.dart
```

#### 4. Injection Template
```bash
# Create the file
touch mason_template/bricks/flutter_clean_architecture_feature/__brick__/{{feature_name}}_injection.dart
```

### Step 2: Test Your Brick Locally

```bash
# Navigate to your project root
cd your_flutter_project

# Add the brick locally
mason add flutter_clean_architecture_feature --path ./mason_template/bricks/flutter_clean_architecture_feature

# Test generation
mason make flutter_clean_architecture_feature
```

### Step 3: Create GitHub Repository

1. Go to GitHub and create a new repository
2. Name it: `flutter-clean-architecture-mason-brick`
3. Make it public
4. Clone it locally

### Step 4: Prepare for Publishing

```bash
# Navigate to your mason_template directory
cd mason_template

# Initialize git
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Flutter Clean Architecture Mason Brick"

# Add remote origin (replace with your GitHub repo URL)
git remote add origin https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git

# Push to GitHub
git push -u origin main
```

### Step 5: Test from GitHub

```bash
# In a new Flutter project, test installation from GitHub
mason add flutter_clean_architecture_feature --git https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git

# Generate a feature
mason make flutter_clean_architecture_feature
```

## 📋 Complete Template Content

Here are the complete templates you need to create:

### 1. Use Case Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/domain/usecases/{{use_case_name|snakeCase}}_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:elmohandes_client/core/error/failures.dart';
import 'package:elmohandes_client/core/usecases/usecases.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/domain/repositories/{{feature_name}}_repository.dart';
{% if cubit_type == 'pagination' -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';

class {{use_case_name|titleCase}}Params extends Equatable {
  final int page;
  final String? searchText;

  const {{use_case_name|titleCase}}Params({
    required this.page,
    this.searchText,
  });

  @override
  List<Object?> get props => [page, searchText];
}

class {{use_case_name|titleCase}}Usecase
    extends UseCase<{{response_model_name}}, {{use_case_name|titleCase}}Params> {
  final {{feature_name|titleCase}}Repository {{feature_name}}Repository;

  {{use_case_name|titleCase}}Usecase({
    required this.{{feature_name}}Repository,
  });

  @override
  Future<Either<Failure, {{response_model_name}}>> call({{use_case_name|titleCase}}Params params) {
    return {{feature_name}}Repository.get{{feature_name|titleCase}}(
      page: params.page,
      searchText: params.searchText,
    );
  }
}
{% else -%}
{% if response_model_name == 'StatusResponse' -%}
import 'package:elmohandes_client/core/entities/status_response.dart';
{% else -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% endif -%}

class {{use_case_name|titleCase}}Usecase
    extends UseCase<{{response_model_name}}, {% if http_method == 'GET' %}NoParams{% elif http_method == 'POST' %}Map<String, dynamic>{% elif http_method == 'PUT' %}Map<String, dynamic>{% elif http_method == 'DELETE' %}int{% endif %}> {
  final {{feature_name|titleCase}}Repository {{feature_name}}Repository;

  {{use_case_name|titleCase}}Usecase({
    required this.{{feature_name}}Repository,
  });

  @override
  Future<Either<Failure, {{response_model_name}}>> call(
    {% if http_method == 'GET' %}NoParams{% elif http_method == 'POST' %}Map<String, dynamic>{% elif http_method == 'PUT' %}Map<String, dynamic>{% elif http_method == 'DELETE' %}int{% endif %} params,
  ) {
{% if http_method == 'GET' -%}
    return {{feature_name}}Repository.get{{feature_name|titleCase}}();
{% elif http_method == 'POST' -%}
    return {{feature_name}}Repository.create{{feature_name|titleCase}}(params);
{% elif http_method == 'PUT' -%}
    return {{feature_name}}Repository.update{{feature_name|titleCase}}(
      id: params['id'],
      body: params['body'],
    );
{% elif http_method == 'DELETE' -%}
    return {{feature_name}}Repository.delete{{feature_name|titleCase}}(params);
{% endif -%}
  }
}
{% endif -%}
```

### 2. Cubit Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_cubit.dart

{% if cubit_type == 'pagination' -%}
import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:elmohandes_client/core/error/failures.dart';
import 'package:elmohandes_client/core/util/request_status.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/domain/usecases/{{use_case_name|snakeCase}}_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '{{cubit_name|snakeCase}}_state.dart';

class {{cubit_name}} extends Cubit<{{cubit_name}}State> {
  final {{use_case_name|titleCase}}Usecase {{use_case_name|snakeCase}}Usecase;
  
  {{cubit_name}}({required this.{{use_case_name|snakeCase}}Usecase})
      : super(
          {{cubit_name}}State(
            allRequestStatus: RequestStatus.initial,
            paginationRequestStatus: RequestStatus.initial,
            {{feature_name}}: <{{data_model_name}}>[],
            currentPage: 1,
            lastPage: 1,
          ),
        );
        
  Timer? _debounce;
  ScrollController scrollController = ScrollController();

  void initScroll() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        loadMore{{feature_name|titleCase}}();
      }
    });
  }

  Future<void> get{{feature_name|titleCase}}ForFirstTime() async {
    emit(
      state.copyWith(
        allRequestStatus: RequestStatus.loading,
        {{feature_name}}: <{{data_model_name}}>[],
        currentPage: 1,
        lastPage: 1,
      ),
    );

    final Either<Failure, {{response_model_name}}> result =
        await {{use_case_name|snakeCase}}Usecase(
          {{use_case_name|titleCase}}Params(
            page: state.currentPage,
            searchText: state.searchText,
          ),
        );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.error,
          generalErrorMessage: failure.message,
        ),
      ),
      ({{response_model_name}} response) => emit(
        state.copyWith(
          allRequestStatus: RequestStatus.success,
          lastPage: response.meta.lastPage,
          {{feature_name}}: response.data,
        ),
      ),
    );
  }

  Future<void> loadMore{{feature_name|titleCase}}() async {
    if (state.currentPage >= state.lastPage) {
      return;
    }
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        paginationRequestStatus: RequestStatus.loading,
      ),
    );
    final Either<Failure, {{response_model_name}}> result =
        await {{use_case_name|snakeCase}}Usecase(
          {{use_case_name|titleCase}}Params(
            page: state.currentPage,
            searchText: state.searchText,
          ),
        );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          currentPage: state.currentPage - 1,
          paginationRequestStatus: RequestStatus.error,
          paginationErrorMessage: failure.message,
        ),
      ),
      ({{response_model_name}} response) => emit(
        state.copyWith(
          paginationRequestStatus: RequestStatus.success,
          {{feature_name}}: List.from(state.{{feature_name}} + response.data),
          currentPage: state.currentPage,
        ),
      ),
    );
  }

  void setFilter({
    String? searchText,
  }) {
    emit(
      state.copyWith(
        searchText: searchText,
        currentPage: 1,
      ),
    );
    if (searchText != null && searchText.isNotEmpty) {
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      }
      _debounce = Timer(const Duration(milliseconds: 500), () {
        get{{feature_name|titleCase}}ForFirstTime();
      });
    } else {
      get{{feature_name|titleCase}}ForFirstTime();
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    _debounce?.cancel();
    return super.close();
  }
}
{% else -%}
import 'package:dartz/dartz.dart';
import 'package:elmohandes_client/core/error/failures.dart';
import 'package:elmohandes_client/core/usecases/usecases.dart';
{% if response_model_name == 'StatusResponse' -%}
import 'package:elmohandes_client/core/entities/status_response.dart';
{% else -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart';
{% endif -%}
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/domain/usecases/{{use_case_name|snakeCase}}_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '{{cubit_name|snakeCase}}_state.dart';

class {{cubit_name}} extends Cubit<{{cubit_name}}State> {
  final {{use_case_name|titleCase}}Usecase {{use_case_name|snakeCase}}Usecase;
  
  {{cubit_name}}({required this.{{use_case_name|snakeCase}}Usecase})
      : super({{cubit_name}}Initial());

{% if http_method == 'GET' -%}
  Future<void> get{{feature_name|titleCase}}() async {
    emit({{cubit_name}}Loading());
    final result = await {{use_case_name|snakeCase}}Usecase(NoParams());
    result.fold(
      (Failure failure) => emit({{cubit_name}}Error(message: failure.message)),
{% if response_model_name == 'StatusResponse' -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded(statusResponse: response)),
{% else -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded({{feature_name|snakeCase}}Response: response)),
{% endif -%}
    );
  }
{% elif http_method == 'POST' -%}
  Future<void> create{{feature_name|titleCase}}(Map<String, dynamic> body) async {
    emit({{cubit_name}}Loading());
    final result = await {{use_case_name|snakeCase}}Usecase(body);
    result.fold(
      (Failure failure) => emit({{cubit_name}}Error(message: failure.message)),
{% if response_model_name == 'StatusResponse' -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded(statusResponse: response)),
{% else -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded({{feature_name|snakeCase}}Response: response)),
{% endif -%}
    );
  }
{% elif http_method == 'PUT' -%}
  Future<void> update{{feature_name|titleCase}}({
    required int id,
    required Map<String, dynamic> body,
  }) async {
    emit({{cubit_name}}Loading());
    final result = await {{use_case_name|snakeCase}}Usecase({
      'id': id,
      'body': body,
    });
    result.fold(
      (Failure failure) => emit({{cubit_name}}Error(message: failure.message)),
{% if response_model_name == 'StatusResponse' -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded(statusResponse: response)),
{% else -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded({{feature_name|snakeCase}}Response: response)),
{% endif -%}
    );
  }
{% elif http_method == 'DELETE' -%}
  Future<void> delete{{feature_name|titleCase}}(int id) async {
    emit({{cubit_name}}Loading());
    final result = await {{use_case_name|snakeCase}}Usecase(id);
    result.fold(
      (Failure failure) => emit({{cubit_name}}Error(message: failure.message)),
{% if response_model_name == 'StatusResponse' -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded(statusResponse: response)),
{% else -%}
      ({{response_model_name}} response) =>
          emit({{cubit_name}}Loaded({{feature_name|snakeCase}}Response: response)),
{% endif -%}
    );
  }
{% endif -%}
}
{% endif -%}
```

### 3. State Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_state.dart

{% if cubit_type == 'pagination' -%}
part of '{{cubit_name|snakeCase}}_cubit.dart';

class {{cubit_name}}State extends Equatable {
  final RequestStatus allRequestStatus;
  final RequestStatus paginationRequestStatus;
  final List<{{data_model_name}}> {{feature_name}};
  final String generalErrorMessage;
  final String paginationErrorMessage;
  final int currentPage;
  final int lastPage;
  final String? searchText;

  const {{cubit_name}}State({
    this.allRequestStatus = RequestStatus.initial,
    this.paginationRequestStatus = RequestStatus.initial,
    this.{{feature_name}} = const <{{data_model_name}}>[],
    this.generalErrorMessage = '',
    this.paginationErrorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
    this.searchText,
  });

  {{cubit_name}}State copyWith({
    RequestStatus? allRequestStatus,
    RequestStatus? paginationRequestStatus,
    List<{{data_model_name}}>? {{feature_name}},
    String? generalErrorMessage,
    String? paginationErrorMessage,
    int? currentPage,
    int? lastPage,
    String? searchText,
  }) {
    return {{cubit_name}}State(
      allRequestStatus: allRequestStatus ?? this.allRequestStatus,
      paginationRequestStatus: paginationRequestStatus ?? this.paginationRequestStatus,
      {{feature_name}}: {{feature_name}} ?? this.{{feature_name}},
      generalErrorMessage: generalErrorMessage ?? this.generalErrorMessage,
      paginationErrorMessage: paginationErrorMessage ?? this.paginationErrorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object?> get props => [
        allRequestStatus,
        paginationRequestStatus,
        {{feature_name}},
        generalErrorMessage,
        paginationErrorMessage,
        currentPage,
        lastPage,
        searchText,
      ];
}
{% else -%}
part of '{{cubit_name|snakeCase}}_cubit.dart';

sealed class {{cubit_name}}State extends Equatable {
  const {{cubit_name}}State();

  @override
  List<Object> get props => [];
}

final class {{cubit_name}}Initial extends {{cubit_name}}State {}

final class {{cubit_name}}Loading extends {{cubit_name}}State {}

final class {{cubit_name}}Loaded extends {{cubit_name}}State {
{% if response_model_name == 'StatusResponse' -%}
  final {{response_model_name}} statusResponse;
  const {{cubit_name}}Loaded({required this.statusResponse});
  
  @override
  List<Object> get props => [statusResponse];
{% else -%}
  final {{response_model_name}} {{feature_name|snakeCase}}Response;
  const {{cubit_name}}Loaded({required this.{{feature_name|snakeCase}}Response});
  
  @override
  List<Object> get props => [{{feature_name|snakeCase}}Response];
{% endif -%}
}

final class {{cubit_name}}Error extends {{cubit_name}}State {
  final String message;
  const {{cubit_name}}Error({required this.message});
  
  @override
  List<Object> get props => [message];
}
{% endif -%}
```

### 4. Injection Template
```dart
// {{feature_name}}_injection.dart

import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/datasources/{{feature_name}}_remote_data_source.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/data/repositories/{{feature_name}}_repository_impl.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/domain/repositories/{{feature_name}}_repository.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/domain/usecases/{{use_case_name|snakeCase}}_usecase.dart';
import 'package:elmohandes_client/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_cubit.dart';
import 'package:elmohandes_client/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void init{{feature_name|titleCase}}Injection() {
  // cubits
  sl.registerFactory<{{cubit_name}}>(
    () => {{cubit_name}}({{use_case_name|snakeCase}}Usecase: sl()),
  );

  // usecases
  sl.registerLazySingleton<{{use_case_name|titleCase}}Usecase>(
    () => {{use_case_name|titleCase}}Usecase({{feature_name}}Repository: sl()),
  );

  // repositories
  sl.registerLazySingleton<{{feature_name|titleCase}}Repository>(
    () => {{feature_name|titleCase}}RepositoryImpl(
      {{feature_name}}RemoteDataSource: sl(),
{% if requires_auth -%}
      authLocalDataSource: sl(),
{% endif -%}
    ),
  );

  // data sources
  sl.registerLazySingleton<{{feature_name|titleCase}}RemoteDataSource>(
    () => {{feature_name|titleCase}}RemoteDataSourceImpl(apiBaseHelper: sl()),
  );
}

List<BlocProvider<Cubit<Object>>> {{feature_name|snakeCase}}Blocs() => <BlocProvider<Cubit<Object>>>[
      BlocProvider<{{cubit_name}}>(
        create: (context) => sl<{{cubit_name}}>(),
      ),
    ];
```

## 🎯 Final Steps

1. **Create the missing template files** with the content above
2. **Test locally** to ensure everything works
3. **Create GitHub repository**
4. **Push to GitHub**
5. **Test installation from GitHub**
6. **Share with the community!**

## 🚀 Usage in Other Projects

Once published, others can use your brick like this:

```bash
# Install Mason
dart pub global activate mason_cli

# Add your brick
mason add flutter_clean_architecture_feature --git https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git

# Generate a feature
mason make flutter_clean_architecture_feature
```

## 🎉 Congratulations!

You now have a complete, production-ready Mason brick that follows Flutter clean architecture best practices and can be shared with the entire Flutter community!
