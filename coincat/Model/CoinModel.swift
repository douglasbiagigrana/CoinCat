//
//  CoinModel.swift
//  coincat
//
//  Created by Douglas Biagi Grana on 08/04/22.
//

import Foundation

struct CoinModel: Codable {
    let coinModel: [Coin]
}

struct Coin: Codable {
    let id, symbol, name: String
}
