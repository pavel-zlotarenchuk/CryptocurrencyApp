//
//  CoinEntity.swift
//  CryptocurrencyApp
//
//  Created by Mac on 4/18/18.
//  Copyright © 2018 Green Moby. All rights reserved.
//

import Foundation

class CoinEntity {
    var coinKey : String = ""
    var coinTitle : String = ""
    var coinPrice : String = ""
    var coin24hСhange : String = ""
    var coin7dСhange : String = ""
    var urlCoinIcon : String = ""
    
    init(coinKey : String, coinTitle : String, coinPrice : String, coin24hСhange : String, coin7dСhange : String) {
        self.coinKey = coinKey
        self.coinTitle = coinTitle
        self.coinPrice = coinPrice
        self.coin24hСhange = coin24hСhange
        self.coin7dСhange = coin7dСhange
    }
}
