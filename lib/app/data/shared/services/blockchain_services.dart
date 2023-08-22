import 'dart:convert';

import 'package:bitcoin_alert/app/data/models/coin_model.dart';
import 'package:http/http.dart' as http;

class BlockchainServices {
  Future<List<CoinModel>> recuperarPreco() async {
    List<CoinModel> listCoins = [];
    try {
      String url = "https://blockchain.info/ticker";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> retorno = json.decode(response.body);
        listCoins.add(CoinModel.fromJson(retorno["USD"]));
        listCoins.add(CoinModel.fromJson(retorno["BRL"]));
      }
      return listCoins;
    } catch (e) {
      return listCoins;
      print(e);
    }
  }
}
