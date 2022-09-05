import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'app_http_method.dart';

/// A Calculator.
class NetworkReTry {
  Future<Completer<http.Response>> retry(
      {Uri? uri,
      Map? body,
      AppHttpMethod? appHttpMethod,
      Map<String, String>? header}) async {
    Completer<http.Response> responseCompletion = Completer();

    StreamSubscription? streamSubscription;

    http.Response? _response;

    streamSubscription =
        Connectivity().onConnectivityChanged.listen((event) async {
      print("Connectivity Response : ${event}");

      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi ||
          event == ConnectivityResult.ethernet) {
        streamSubscription!.cancel();

        switch (appHttpMethod) {
          case AppHttpMethod.POST:
            // TODO: Handle this case.
            _response = await handlePostRequest(uri, body, header);

            print("Re-try response : ${_response!.body}");

            responseCompletion.complete(_response);
            break;
          case AppHttpMethod.GET:
            _response = await handleGetRequest(uri, body, header);
            print("Re-try response : ${_response!.body}");

            responseCompletion.complete(_response);
            break;
          case AppHttpMethod.DELETE:
            _response = await handleDeleteRequest(uri, body, header);
            // print("Re-try response : ${_response!.body}");

            responseCompletion.complete(_response);
            break;
          case AppHttpMethod.PUT:
            _response = await handlePutRequest(uri, body, header);
            // print("Re-try response : ${_response!.body}");

            responseCompletion.complete(_response);
            break;
          default:
            _response = null;
        }
      }
    });

    print("Re-try response : final ${_response}");

    return responseCompletion;
  }

  Future<http.Response> handlePostRequest(
      Uri? uri, Map? map, Map<String, String>? header) async {
    return await http.post(uri!, headers: header, body: jsonEncode(map));
  }

  Future<http.Response> handleGetRequest(
      Uri? uri, Map? map, Map<String, String>? header) async {
    return await http.get(
      uri!,
      headers: header,
    );
  }

  Future<http.Response> handlePutRequest(
      Uri? uri, Map? map, Map<String, String>? header) async {
    return await http.put(uri!, headers: header, body: jsonEncode(map));
  }

  Future<http.Response> handleDeleteRequest(
      Uri? uri, Map? map, Map<String, String>? header) async {
    return await http.delete(uri!, headers: header, body: jsonEncode(map));
  }
}
