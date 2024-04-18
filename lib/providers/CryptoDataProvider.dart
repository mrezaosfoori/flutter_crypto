import 'package:demo/data/data_source/ApiProvider.dart';
import 'package:demo/data/data_source/ResponseModel.dart';
import 'package:demo/data/models/CryptoModel/AllCryptoModel.dart';
import 'package:flutter/material.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();

  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;
  int defaultChoiceIndex = 0;

  getTopMarketData() async {
    defaultChoiceIndex = 0;
    notifyListeners();
    state = ResponseModel.loading("... is loading");
    try {
      response = await apiProvider.getTopMarketCapData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("api dosnt work");
      }
      notifyListeners();
    } catch (e) {
      print(e);
      state = ResponseModel.error("network error");
      notifyListeners();
    }
  }

  getTopGainers() async {
     defaultChoiceIndex = 1;
    notifyListeners();
    state = ResponseModel.loading("... is loading");
    try {
      response = await apiProvider.getTopGainerData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("api dosnt work");
      }
      notifyListeners();
    } catch (e) {
      print(e);
      state = ResponseModel.error("network error");
      notifyListeners();
    }
  }

  getTopLosers() async {
     defaultChoiceIndex = 2;
    notifyListeners();
    state = ResponseModel.loading("... is loading");
    try {
      response = await apiProvider.getTopLosersData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("api dosnt work");
      }
      notifyListeners();
    } catch (e) {
      print(e);
      state = ResponseModel.error("network error");
      notifyListeners();
    }
  }
}
