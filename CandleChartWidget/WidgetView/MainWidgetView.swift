//
//  MainWidgetView.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import SwiftUI

struct MainWidgetView: View {
    
    var data: DataProvider.Entry
    
    //MARK:- Oversize frameHeight for chart zooming
    let frameHeight: CGFloat = 900
    let horizontalPadding: CGFloat = 15
    
    var body: some View {
        ZStack {
            
            //MARK:- Main view background color
            Rectangle().fill(Color.black)
            
            //MARK:- Header with crypto info
            HeaderView(
                openPrice: data.cryptoData[0].openPrice,
                parentHeight: frameHeight)
            
            //MARK:- Candle chart
            CandleChartView(
                data: data.cryptoData,
                maxValue: data.maxValue,
                minValue: data.minValue)
            .frame(height: frameHeight)
            .padding(.horizontal, horizontalPadding)
            
        }
    }
}

//MARK:- Preview
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
