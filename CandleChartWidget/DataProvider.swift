//
//  DataProvider.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import Foundation
import WidgetKit
import SwiftUI


struct DataProvider: TimelineProvider {
    func timeline(with context: Context, completion: @escaping (Timeline<WidgetDataModel>) -> ()) {
        let date = Date()
        let cryptoDailyLoader = CryptoDailyLoader()
        
        cryptoDailyLoader.load { result in
            let cryptoDailyData: CryptoDailyData
            if case .success(let fetchedData) = result {
                cryptoDailyData = fetchedData
   
                let cryptoData = initDailyCryptoList(cryptoDailyData)
                
                for i in cryptoData {
                    print(i.date)
                }
                
                let timeLineData = WidgetDataModel(
                    date: date,
                    cryptoData: cryptoData)
                
                let updateValue: Int = 1
                let timePeriod = Calendar.Component.hour
                let refreshDate = Calendar.current.date(byAdding: timePeriod, value: updateValue, to: date)!
                let timeLine = Timeline(entries: [timeLineData], policy: .after(refreshDate))
                
                completion(timeLine)
            }//success case
        }//load
    }//timeline
    
    func snapshot(with context: Context, completion: @escaping (WidgetDataModel) -> ()) {
        let date = Date()
        let timeLineData = WidgetDataModel(
            date: date,
            cryptoData: [
                CryptoData(
                    date: "N/A",
                    openPrice: 0.0,
                    closePrice: 0.0,
                    highPrice: 0.0,
                    lowPrice: 0.0)
            ])
        completion(timeLineData)
    }
    
}

func initDailyCryptoList(_ cryptoDailyData: CryptoDailyData) -> [CryptoData] {
    var cryptoData: [CryptoData] = []
    var dateArray: [String] = []
    
    let currentDate = Date()
    
    //MARK:- create last 20 dates
    for i in 0...22 {
        let date = Calendar.current.date(byAdding: .day, value: -i, to: currentDate)
        let str = date!.getFormattedDate(format: "yyyy-MM-dd")
        dateArray.append(str)
    }
    
    for dateValue in dateArray {
        cryptoData.append(
            CryptoData(
                date: dateValue,
                openPrice: Double(cryptoDailyData.timeSeriesDigitalCurrencyDaily[dateValue]!.the1BOpenUSD)!,
                closePrice: Double(cryptoDailyData.timeSeriesDigitalCurrencyDaily[dateValue]!.the4BCloseUSD)!,
                highPrice: Double(cryptoDailyData.timeSeriesDigitalCurrencyDaily[dateValue]!.the2BHighUSD)!,
                lowPrice: Double(cryptoDailyData.timeSeriesDigitalCurrencyDaily[dateValue]!.the3BLowUSD)!)
        )
    }
    
    return cryptoData
}