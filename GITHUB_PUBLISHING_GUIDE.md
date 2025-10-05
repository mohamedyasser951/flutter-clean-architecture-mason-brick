# Publishing Mason Template to GitHub & Usage Guide

## 🚀 Publishing to GitHub

### Step 1: Create a GitHub Repository

1. Go to GitHub and create a new repository
2. Name it something like `flutter-clean-architecture-mason-brick`
3. Make it public so others can use it
4. Add a good README.md

### Step 2: Prepare Your Local Repository

```bash
# Initialize git in your mason_template directory
cd mason_template
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit: Flutter Clean Architecture Mason Brick"

# Add remote origin (replace with your GitHub repo URL)
git remote add origin https://github.com/mohamedyasser951/flutter-clean-architecture-mason-brick.git

# Push to GitHub
git push -u origin main
```

### Step 3: Create a Proper Repository Structure

Your final repository structure should look like this:

```
flutter-clean-architecture-mason-brick/
├── README.md
├── LICENSE
├── bricks/
│   └── flutter_clean_architecture_feature/
│       └── __brick__/
│           ├── brick.yaml
│           └── lib/
│               └── {{module_name}}/
│                   └── features/
│                       └── {{feature_name}}/
│                           ├── data/
│                           │   ├── datasources/
│                           │   ├── models/
│                           │   └── repositories/
│                           ├── domain/
│                           │   ├── repositories/
│                           │   └── usecases/
│                           └── presentation/
│                               └── cubit/
└── {{feature_name}}_injection.dart
```

### Step 4: Create a Comprehensive README.md

```markdown
# Flutter Clean Architecture Mason Brick

A comprehensive Mason brick for generating Flutter features following clean architecture principles with Cubit state management.

## Features

- ✅ Clean Architecture (Data, Domain, Presentation layers)
- ✅ Cubit state management with two patterns:
  - **Pagination Cubit**: For list features with pagination support
  - **Simple Cubit**: For basic CRUD operations
- ✅ Dependency Injection with GetIt
- ✅ Error handling with Either<Failure, Success>
- ✅ API integration with Dio
- ✅ Authentication support
- ✅ Repository pattern
- ✅ Use case pattern

## Installation

### 1. Install Mason CLI
```bash
dart pub global activate mason_cli
```

### 2. Add this brick to your project
```bash
mason add flutter_clean_architecture_feature --git https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git
```

### 3. Generate a new feature
```bash
mason make flutter_clean_architecture_feature
```

## Configuration Options

[Include the configuration table from your existing documentation]

## Examples

[Include your examples]

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
```

### Step 5: Add License File

Create a `LICENSE` file (MIT License example):

```text
MIT License

Copyright (c) 2024 [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 📦 Using in Another Project

### Method 1: Using Git URL (Recommended)

```bash
# In your new Flutter project
mason add flutter_clean_architecture_feature --git https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git

# Generate a feature
mason make flutter_clean_architecture_feature
```

### Method 2: Using Local Path

```bash
# Clone the repository locally
git clone https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git

# In your Flutter project, add the brick using local path
mason add flutter_clean_architecture_feature --path ../flutter-clean-architecture-mason-brick/bricks/flutter_clean_architecture_feature

# Generate a feature
mason make flutter_clean_architecture_feature
```

### Method 3: Publishing to Mason Registry (Advanced)

If you want to publish to the official Mason registry:

1. **Create a mason.yaml file in your repository root:**

```yaml
name: flutter_clean_architecture_feature
description: A comprehensive Flutter clean architecture feature template with Cubit state management
version: 1.0.0
environment:
  mason: ">=0.1.0-dev <0.1.0"
bricks:
  flutter_clean_architecture_feature:
    path: ./bricks/flutter_clean_architecture_feature
```

2. **Submit to Mason Registry:**
   - Go to [Mason Registry](https://registry.brickhub.dev/)
   - Follow their submission process
   - Once approved, users can install with:
   ```bash
   mason add flutter_clean_architecture_feature
   ```

## 🔧 Complete Template Files

Here are the essential template files you need to create:

### 1. Data Source Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/data/datasources/{{feature_name}}_remote_data_source.dart
[Your data source template content]
```

### 2. Repository Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/domain/repositories/{{feature_name}}_repository.dart
[Your repository interface template]
```

### 3. Repository Implementation
```dart
// lib/{{module_name}}/features/{{feature_name}}/data/repositories/{{feature_name}}_repository_impl.dart
[Your repository implementation template]
```

### 4. Use Case Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/domain/usecases/{{use_case_name|snakeCase}}_usecase.dart
[Your use case template]
```

### 5. Cubit Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_cubit.dart
[Your cubit template]
```

### 6. State Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/presentation/cubit/{{cubit_name|snakeCase}}_state.dart
[Your state template]
```

### 7. Response Model Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/data/models/{{feature_name}}_response.dart
[Your response model template]
```

### 8. Injection Template
```dart
// lib/{{module_name}}/features/{{feature_name}}/{{feature_name}}_injection.dart
[Your dependency injection template]
```

## 🎯 Best Practices for Publishing

### 1. Version Management
- Use semantic versioning (1.0.0, 1.1.0, 2.0.0)
- Update the version in `brick.yaml` for each release
- Tag your releases in GitHub

### 2. Documentation
- Provide comprehensive README
- Include usage examples
- Document all configuration options
- Add troubleshooting section

### 3. Testing
- Test the brick with different configurations
- Ensure generated code compiles
- Test integration with existing projects

### 4. Community
- Accept contributions via Pull Requests
- Respond to issues promptly
- Keep documentation up to date

## 🚀 Quick Start for Users

Once published, users can quickly get started:

```bash
# Install Mason
dart pub global activate mason_cli

# Add your brick
mason add flutter_clean_architecture_feature --git https://github.com/YOUR_USERNAME/flutter-clean-architecture-mason-brick.git

# Generate a feature
mason make flutter_clean_architecture_feature
# Follow the prompts to configure your feature

# Example: Products list with pagination
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

## 📝 Release Checklist

Before publishing a new version:

- [ ] Test with multiple configurations
- [ ] Update version in `brick.yaml`
- [ ] Update CHANGELOG.md
- [ ] Update README.md if needed
- [ ] Create GitHub release
- [ ] Tag the release
- [ ] Test installation from GitHub

## 🔗 Useful Links

- [Mason Documentation](https://docs.brickhub.dev/)
- [Mason Registry](https://registry.brickhub.dev/)
- [Flutter Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Bloc State Management](https://bloclibrary.dev/)

This guide will help you successfully publish your Mason brick and make it available for the Flutter community to use!
