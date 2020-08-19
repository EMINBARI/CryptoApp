//
//  Data.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import Foundation

struct CData: Hashable {
    let highPrice: Double
    let lowPrice: Double
    let max: Double
    let min: Double
    let id: Int
    let date: String
    
}

let measurements: [CData] = [
    .init(highPrice: 5.0, lowPrice: 3, max: 4, min: 3.5, id: 1, date: "2020-08-18"),
    .init(highPrice: 6.0, lowPrice: 4, max: 5, min: 3.2, id: 2, date: "2020-08-17"),
    .init(highPrice: 5.5, lowPrice: 2.6, max: 4, min: 2, id: 3, date: "2020-08-16"),
    .init(highPrice: 3.5, lowPrice: 2.8, max: 3, min: 2.5, id: 4, date: "2020-08-15"),
    .init(highPrice: 10.0, lowPrice: 4.8, max: 8, min: 3.5, id: 5, date: "2020-08-14"),
    .init(highPrice: 8.2, lowPrice: 4.3, max: 8.2, min: 5.5, id: 6, date: "2020-08-13"),
    .init(highPrice: 4.7, lowPrice: 3, max: 4.1, min: 2.5, id: 7, date: "2020-08-12"),
    .init(highPrice: 6.3, lowPrice: 5.1, max: 5.7, min: 4.5, id: 8, date: "2020-08-11"),
    .init(highPrice: 5.4, lowPrice: 4, max: 4.5, min: 4.3, id: 9, date: "2020-08-10"),
]
