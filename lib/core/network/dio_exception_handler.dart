import 'package:dio/dio.dart';



  DioException mapDioException(Object error, RequestOptions requestOptions) {
    if (error is DioException) {
      return DioException(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        error: error.error,
        stackTrace: error.stackTrace,
        message: _friendlyMessage(error),
      );
    }
    return DioException(
      requestOptions: requestOptions,
      type: DioExceptionType.unknown,
      error: error,
      message: 'Received unexpected data from the server.',
    );
  }

  String _friendlyMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The request timed out. Please try again.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.badResponse:
        return _messageForStatus(error.response?.statusCode);
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }


  String _messageForStatus(int? code) {
    if (code == null) return 'Server error occurred.';
    if (code == 401 || code == 403) return 'Unauthorized request.';
    if (code == 404) return 'Requested resource not found.';
    if (code >= 500) return 'Server error. Please try again later.';
    return 'Request failed ($code).';
  }
