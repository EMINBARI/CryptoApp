//
//  CryptoDailyLoader.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import Foundation

class CryptoDailyLoader {
    
    private let baseURL = "https://www.alphavantage.co/query"
    private let function = "DIGITAL_CURRENCY_DAILY"
    private let key = "J9E4HBRSCD82AF9Q"
    private let symbol = "BTC"
    private let market = "EUR"
   
    private var requestURL: String {
        get {
            return baseURL + "?function=" + function + "&symbol=" + symbol + "&market=" + market + "&apikey=" + key
        }
    }
    
    func load(complited: @escaping (Result<CryptoDailyData, Error>) -> Void) {
        guard let url = URL(string: requestURL) else {
            return assertionFailure("Url is not correct")
        }
        
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            if let data = data {
                let decoder = JSONDecoder()
                if let loadedCryptoData = try? decoder.decode(CryptoDailyData.self, from: data) {
                    complited(.success(loadedCryptoData))
                }
            }
        }.resume()
    }
    
}

