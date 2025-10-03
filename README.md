# flutter_application_2

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Clean Architecture

This project follows the principles of Clean Architecture to separate concerns and create a more maintainable and testable codebase.

### Layers

The code is organized into the following layers:

- **Domain**: Contains the core business logic and entities of the application. It has no dependencies on other layers.
- **Application**: Contains the application-specific business logic (use cases). It depends on the Domain layer.
- **Infrastructure**: Contains the implementation details, such as data sources (APIs, databases) and repositories. It depends on the Domain layer.
- **Presentation**: Contains the UI and state management logic. It depends on the Application layer.

### Dependency Rule

The dependencies between layers flow inwards:

`Presentation -> Application -> Domain`

`Infrastructure -> Domain`

The `Domain` layer is the center of the architecture and has no outgoing dependencies.

### Folder Structure

The project is organized as follows:

- `lib/src/domain`: Contains entities and repository interfaces.
- `lib/src/application`: Contains use cases.
- `lib/src/infrastructure`: Contains repository implementations and data sources.
- `lib/src/presentation`: Contains UI (widgets) and state management (controllers).
- `lib/src/shared`: Contains shared code, such as dependency injection configuration.

### Dependency Injection

This project uses the `get_it` package for dependency injection. The service locator is configured in `lib/src/shared/di/service_locator.dart` and initialized in `lib/main.dart`.

### Development Rules

- New features should be added as use cases in the Application layer.
- UI components should only interact with the Application layer through use cases.
- External services (APIs, databases, etc.) should be accessed through data sources in the Infrastructure layer.
