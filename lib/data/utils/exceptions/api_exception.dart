import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_temp_by_nqh/app/multi_languages/multi_languages_utils.dart';

class ApiException {
  String? errorCode;
  String? errorMessage = "";
  int? statusCode;
  late DioError exception;

  String get displayError {
    if (exception.type == DioErrorType.connectTimeout) {
      return LocaleKeys.connectTimeout.tr();
    }

    if (exception.type == DioErrorType.receiveTimeout) {
      return LocaleKeys.receiveTimeout.tr();
    }

    if (exception.type == DioErrorType.sendTimeout) {
      return LocaleKeys.sendTimeout.tr();
    }

    if (exception.type == DioErrorType.other) {
      if (exception.error is SocketException) {
        return LocaleKeys.pleaseCheckYourInternetConnection.tr();
      }
      return exception.error.toString();
    }

    // Prioritize error returned in response body
    final responseData = exception.response?.data;

    if (responseData is Map && responseData["message"] != null) {
      if (responseData["message"] is List) {
        /// We get first error message return from backend if message error is List, Can join later
        final List<dynamic> listErrorMessage = responseData["message"];
        return listErrorMessage.first.toString();
      } else {
        return responseData["message"].toString();
      }
    }

    // Fallback to request error if no error returned in response body
    return errorMessage!;
  }

  ApiException({required this.exception}) {
    switch (exception.type) {
      case DioErrorType.response:
        {
          dynamic errorBody = exception.response?.data;

          try {
            errorCode = errorBody['error'];
            if (errorBody['message'] is List) {
              errorMessage = errorBody['message'][0];
            } else {
              errorMessage = errorBody['message'];
            }
            statusCode = errorBody['statusCode'];
          } catch (e) {
            errorMessage = e.toString();

            // Try to get Dio internal error which might due to service not available
            if (exception.error != null) {
              errorMessage = exception.error.toString();
            }

            if (exception.response?.statusMessage != null &&
                exception.response!.statusMessage!.isNotEmpty) {
              errorMessage = exception.response?.statusMessage;
            }

            try {
              // ignore: no_leading_underscores_for_local_identifiers
              final _errBody = jsonDecode(errorBody);

              statusCode = _errBody['statusCode'];
              if (_errBody['message'] is List) {
                errorMessage = _errBody['message'][0];
              } else {
                errorMessage = _errBody['message'];
              }
            } catch (e) {
              throw Exception(e);
            }
          }
        }
        break;
      default:
        {
          switch (exception.type) {
            case DioErrorType.cancel:
              {
                errorMessage = LocaleKeys.cancelled.tr();
                break;
              }
            case DioErrorType.connectTimeout:
            case DioErrorType.receiveTimeout:
            case DioErrorType.sendTimeout:
              {
                errorMessage = LocaleKeys.connectTimeout.tr();
              }
              break;
            default:
              {
                if (exception.error is SocketException) {
                  errorMessage = LocaleKeys.connectionProblem.tr();
                } else if (exception.error is HttpException) {
                  errorMessage = LocaleKeys.connectionProblem.tr();
                }
              }
          }
        }
    }
  }
}
