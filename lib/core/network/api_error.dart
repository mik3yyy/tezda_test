part of 'network.dart';

class ApiError implements Exception {
  final String errorDescription;
  final dynamic data;
  final DioExceptionType? dioErrorType;
  final int? statusCode;
  static const unknownError = 'Something went wrong, please try again';
  static const internetError = 'Internet connection error, please try again';
  static const cancelError = 'API request canceled, please try again';
  static const internetError2 =
      'Please check your internet connection, seems you are offline';

  ApiError({
    required this.errorDescription,
    this.data,
    this.dioErrorType,
    this.statusCode,
  });

  factory ApiError.fromDioError(DioException error) {
    String description = '';
    switch (error.type) {
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        description = unknownError;
        break;
      case DioExceptionType.badResponse:
        description = extractDescriptionFromResponse(error.response);
        break;
      case DioExceptionType.cancel:
        description = cancelError;
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.connectionError:
        description = unknownError;
        if (error.error is SocketException) {
          description = internetError;
        } else {
          description = unknownError;
        }
        break;
    }
    return ApiError(
      errorDescription: description,
      dioErrorType: error.type,
      data: "",
      statusCode: error.response?.statusCode,
    );
  }
  static String extractDescriptionFromResponse(Response? response) {
    try {
      if (response == null) {
        return 'No response from server. Please check your connection and try again.';
      }

      final statusCode = response.statusCode ?? 0;

      if (statusCode >= 500) {
        return 'Internal Server Error. Please try again later.';
      } else if (statusCode == 401) {
        return 'Unauthorized access. Please check your credentials and try again.';
      } else if (statusCode == 403) {
        return 'Access forbidden. You do not have permission to access this resource.';
      } else if (statusCode == 404) {
        return 'Resource not found. Please check the URL or try again later.';
      } else if (statusCode == 422) {
        return 'Validation error. Please check the input data and try again.';
      } else if (statusCode == 400) {
        return 'Bad request. Please verify the request parameters.';
      } else if (statusCode >= 300 && statusCode < 400) {
        return 'Redirection error. Please try again later.';
      } else if (statusCode < 200) {
        return 'Unexpected server response. Please try again later.';
      }

      // If no specific message is matched
      return 'An unknown error occurred (status code: $statusCode). Please try again later.';
    } catch (error) {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  @override
  String toString() => errorDescription;
}
