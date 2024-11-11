sealed class AppState<T> {}

class InitialAppState<T> extends AppState<T> {}

class LoadingAppState<T> extends AppState<T> {}

class SuccessAppState<T> extends AppState<T> {
  final T? data;

  SuccessAppState({this.data});
}

class ListAppState<T> extends AppState<T> {
  final List<T> data;
  ListAppState([this.data = const []]);
}

class FailureAppState<T> extends AppState<T> {
  final String error;
  FailureAppState(this.error);
}
