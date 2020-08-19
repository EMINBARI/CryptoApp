//
//  CryptoData.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import Foundation

// MARK: - CryptoDailyData
struct CryptoDailyData: Codable {
    let metaData: MetaData
    let timeSeriesDigitalCurrencyDaily: [String: TimeSeriesDigitalCurrencyDaily]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDigitalCurrencyDaily = "Time Series (Digital Currency Daily)"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let the1Information, the2DigitalCurrencyCode, the3DigitalCurrencyName, the4MarketCode: String
    let the5MarketName, the6LastRefreshed, the7TimeZone: String

    enum CodingKeys: String, CodingKey {
        case the1Information = "1. Information"
        case the2DigitalCurrencyCode = "2. Digital Currency Code"
        case the3DigitalCurrencyName = "3. Digital Currency Name"
        case the4MarketCode = "4. Market Code"
        case the5MarketName = "5. Market Name"
        case the6LastRefreshed = "6. Last Refreshed"
        case the7TimeZone = "7. Time Zone"
    }
}

// MARK: - TimeSeriesDigitalCurrencyDaily
struct TimeSeriesDigitalCurrencyDaily: Codable {
    let the1AOpenEUR, the1BOpenUSD, the2AHighEUR, the2BHighUSD: String
    let the3ALowEUR, the3BLowUSD, the4ACloseEUR, the4BCloseUSD: String
    let the5Volume, the6MarketCapUSD: String

    enum CodingKeys: String, CodingKey {
        case the1AOpenEUR = "1a. open (EUR)"
        case the1BOpenUSD = "1b. open (USD)"
        case the2AHighEUR = "2a. high (EUR)"
        case the2BHighUSD = "2b. high (USD)"
        case the3ALowEUR = "3a. low (EUR)"
        case the3BLowUSD = "3b. low (USD)"
        case the4ACloseEUR = "4a. close (EUR)"
        case the4BCloseUSD = "4b. close (USD)"
        case the5Volume = "5. volume"
        case the6MarketCapUSD = "6. market cap (USD)"
    }
}
