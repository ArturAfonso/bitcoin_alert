import 'dart:convert';

import 'package:bitcoin_alert/app/data/models/coin_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class BlockchainServices {
  Future<List<CoinModel>> recuperarPreco({String? coin}) async {
    List<CoinModel> listCoins = [];
    try {
      String url = "https://blockchain.info/ticker";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> retorno = json.decode(response.body);
        if (coin != null) {
          listCoins.add(CoinModel.fromJson(retorno[coin]));
          return listCoins;
        } else {
          listCoins.add(CoinModel.fromJson(retorno["USD"]));
          listCoins.add(CoinModel.fromJson(retorno["BRL"]));
          return listCoins;
        }
      } else {
        return listCoins;
      }
    } catch (e) {
      return listCoins;
      print(e);
    }
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.currency(
      symbol: "\$ ",
    );
    var value = numberFormat.format(price);

    return numberFormat.format(price);
  }
}
