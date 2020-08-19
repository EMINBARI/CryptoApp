//
//  WidgetDataModel.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import Foundation
import WidgetKit


struct WidgetDataModel: TimelineEntry{
    let date: Date
    let cryptoData: [CryptoData]
}

struct CryptoData: Hashable{
    let date: String
    let openPrice: Double
    let closePrice: Double
    let highPrice: Double
    let lowPrice: Double
}
