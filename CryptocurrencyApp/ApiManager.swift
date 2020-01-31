//
//  ApiManager.swift
//  CryptocurrencyApp
//
//  Created by Mac on 4/18/18.
//  Copyright © 2018 Green Moby. All rights reserved.
//

import Foundation
import AFNetworking

class ApiManager{
    
    static let urlCoins = "https://api.coinmarketcap.com" + "/v1/ticker/"
    static let urlIcons = "https://www.cryptocompare.com"
    
    private func getAFHTTPSessionManager()->AFHTTPSessionManager{
        let managerCrypto = AFHTTPSessionManager()
        managerCrypto.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        managerCrypto.responseSerializer.acceptableContentTypes = NSSet(objects: ["application/json", "text/html"]) as? Set<String>
        return managerCrypto
    }
    
    public func getCrypto(complite : @escaping ([CoinEntity]) -> ()){
        var coinEntites = [CoinEntity]()
        getAFHTTPSessionManager().get(ApiManager.urlCoins, parameters: nil, progress: nil, success: { (task, data) in
            if let json = data as? Array<Dictionary<String, Any>>{
                for coin in json{
                    let coinEntity = CoinEntity(coinKey: coin["symbol"] as! String,
                                                coinTitle: coin["name"] as! String,
                                                coinPrice: coin["price_usd"] as! String,
                                                coin24hСhange: coin["percent_change_24h"] as! String,
                                                coin7dСhange: coin["percent_change_7d"] as! String)
                    coinEntites.append(coinEntity)
                }
                
                self.getIcons(coinEntites: coinEntites, complite: complite)
            }
        }, failure: { (task, error) in
            print(error)
        })
    }
    
    private func getIcons(coinEntites: [CoinEntity], complite : @escaping ([CoinEntity]) -> ()){
        getAFHTTPSessionManager().get(ApiManager.urlIcons + "/api/data/coinlist/", parameters: nil, progress: nil, success: { (task, data) in
            if let json = data as? Dictionary<String, Any?>, let list = json["Data"] as? Dictionary<String, Any?>{
                for item in list{
                    if let coin = item.value as? Dictionary<String, Any?>{
                        for coinEntity in coinEntites{
                            if coinEntity.coinKey == item.key {
                                coinEntity.urlCoinIcon = coin["ImageUrl"] as! String
                            }
                        }
                    }
                }
                complite(coinEntites)
            }
        }, failure: { (task, error) in
            print(error)
        })
    }
}
