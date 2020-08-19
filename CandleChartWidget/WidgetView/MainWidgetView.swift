//
//  MainWidgetView.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import SwiftUI

struct MainWidgetView: View {
    
    var data: DataProvider.Entry
    
    var formatedCurrencyValue: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            guard let formattedNumber = numberFormatter.string(from: NSNumber(value:data.cryptoData[0].openPrice)) else {return "N/A"}
            return formattedNumber
        }
    }
    
    var getDate: String {
        get {
         let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM, yyyy"
            return formatter.string(from: currentDate)
        }
    }
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.black)
            HStack {
                VStack (alignment: .leading) {
                    HStack {
                        Text("BTC/USD")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("$" + formatedCurrencyValue)
                            .font(.body)
                            .bold()
                            .foregroundColor(Color.white.opacity(0.9))
                    }
                    Text(getDate)
                        .font(.caption)
                        .bold()
                        .foregroundColor(Color.white.opacity(0.9))
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.horizontal, 15)
                .zIndex(1)
                
                Spacer()
            }
            
            CandleChartView(
                data: data.cryptoData,
                maxValue: data.maxValue,
                minValue: data.minValue
            )
            .padding(.horizontal, 15)
        }
    }
}

struct MainWidgetView_Previews: PreviewProvider {
    let data: DataProvider.Entry
    static var previews: some View {
        MainWidgetView(
            data: DataProvider.Entry.init(
                date: Date(),
                cryptoData: [CryptoData(
                                date: "",
                                openPrice: 0.0,
                                closePrice: 0.0,
                                highPrice: 0.0,
                                lowPrice: 0.0)],
                maxValue: 0.0,
                minValue: 0.0))
    }
}
