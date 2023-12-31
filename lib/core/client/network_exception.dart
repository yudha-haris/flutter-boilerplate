import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final String? message;
  final String? prefix;
  final Response? response;

  NetworkException({
    this.message,
    this.prefix,
    this.response,
  });

  static NetworkException handleBadResponse(Response? response) {
    var statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
        return BadRequestException(response: response);
      case 401:
        return UnauthorisedException(response: response);
      case 403:
        return BadRequestException(response: response);
      case 404:
        return NotFoundException(response: response);
      case 409:
        return ConflictException(response: response);
      case 408:
        return SendTimeOutException();
      case 413:
        return RequestEntityTooLargeException(response: response);
      case 422:
        return UnprocessableEntityException(response: response);
      case 500:
        return InternalServerErrorException();
      case 503:
        return InternalServerErrorException();
      default:
        var responseCode = statusCode;
        return FetchDataException(
          message: 'Received invalid status code: $responseCode',
          response: response,
        );
    }
  }
}

class ConnectionTimeOutException extends NetworkException {
  ConnectionTimeOutException() : super(prefix: 'Connection Timeout');
}

class ReceiveTimeOutException extends NetworkException {
  ReceiveTimeOutException() : super(prefix: 'Receive Timeout');
}

class SendTimeOutException extends NetworkException {
  SendTimeOutException() : super(prefix: 'Send Timeout');
}

class InternalServerErrorException extends NetworkException {
  InternalServerErrorException() : super(prefix: 'Internal Server Error');
}

class ConflictException extends NetworkException {
  ConflictException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Conflict',
    response: response,
  );
}

class RequestEntityTooLargeException extends NetworkException {
  RequestEntityTooLargeException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Request Entity Too Large',
    response: response,
  );
}

class FetchDataException extends NetworkException {
  FetchDataException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Error During Communication',
    response: response,
  );
}

class NotFoundException extends NetworkException {
  NotFoundException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Not Found',
    response: response,
  );
}

class UnprocessableEntityException extends NetworkException {
  UnprocessableEntityException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Invalid Request',
    response: response,
  );

  String? getErrorMessage() {
    return response?.data != null && response?.data['message'] != null ? response!.data['message'] : null;
  }
}

class BadRequestException extends NetworkException {
  BadRequestException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Invalid Request',
    response: response,
  );

  String? getErrorMessage() {
    return response?.data != null && response?.data['message'] != null ? response!.data['message'] : null;
  }
}

class UnauthorisedException extends NetworkException {
  UnauthorisedException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Unauthorised',
    response: response,
  );
}

class InvalidInputException extends NetworkException {
  InvalidInputException({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Invalid Input',
    response: response,
  );
}

class RequestCancelled extends NetworkException {
  RequestCancelled({String? message, Response? response})
      : super(
    message: message,
    prefix: 'Request Cancelled',
    response: response,
  );
}

class BadCertificate extends NetworkException {
  BadCertificate({String? message, Response? response})
      : super(
    message: message,
    prefix: 'BadCertificate',
    response: response,
  );
}


class GeneralException extends NetworkException {
  GeneralException({String? message})
      : super(
    message: message,
    prefix: 'General Exception',
  );
}