**App network re-try** 

**Benefits** 

This package will help to re API call when the device will connect with the internet. Currently supporting POST, GET, PUT, and DELETE requests. 

**How to use** 
```
if (await sl<AppNetworkInfo>().isConnected) {
      // call API
    } else {
      try {
        Completer<http.Response> _response = await NetworkReTry().retry(
            uri: Uri.parse(AppRemoteHelper.appUrls.source),
            appHttpMethod: AppHttpMethod.GET);

        AppApiResponse? _appApiResponse;

        var _res = await _response.future;

        _appApiResponse = AppApiResponse.data(
          response: _res,
        );

        print("The response after re - try  ${_appApiResponse!.body}");

        Utils.closeDialog();

        return Right(_appApiResponse);
      } catch (err) {
        return Left(ServerFailure(err.toString()));
      }
    }
```

The focus part of the above code 

```
  Completer<http.Response> _response = await NetworkReTry().retry(
            uri: Uri.parse(AppRemoteHelper.appUrls.source),
            appHttpMethod: AppHttpMethod.GET);
```
The retry function will return  ` Completer<http.Response>  ` type data. 

And the parameters of retry functions.

>       Uri? uri,
>       Map? body,
>       AppHttpMethod? appHttpMethod,
>       Map<String, String>? header



**How to add with flutter `pubspec.yaml` file ?**

![Screenshot 2022-09-08 at 9 55 59 AM](https://user-images.githubusercontent.com/45905451/189030894-47a67f29-d4c2-4415-91da-624815bcd330.png)

**What will be the next update?** 

Currently, we are working on the file uploading process.


*Feel free to create an issue to improve package purpose.*  

Thank you.
