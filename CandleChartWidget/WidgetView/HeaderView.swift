//
//  Header.swift
//  CryptoApp
//
//  Created by Emin Bari on 20.08.2020.
//

import SwiftUI

struct HeaderView: View {
    
    let openPrice: Double
    let parentHeight: CGFloat
    
    let zValue: Double = 1
    
    var topOffset: CGFloat {
        get {
            return (parentHeight / 2) - 85
        }
    }
    
    var formatedCurrencyValue: String {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            guard let formattedNumber = numberFormatter.string(from: NSNumber(value: openPrice)) else {return "N/A"}
            return formattedNumber
        }
    }
    
    var formattedDate: String {
        get {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM, yyyy"
            return formatter.string(from: currentDate)
        }
    }
    
    let horizontalPadding: CGFloat = 15
    let topPaddong: CGFloat = 10
    let opacityValue: Double = 0.9
    let exchangeCurrencies: String = "BTC/USD"
    let dollarSign: String = "$"
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                HStack {
                    Text(exchangeCurrencies)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text(dollarSign + formatedCurrencyValue)
                        .font(.body)
                        .bold()
                        .foregroundColor(Color.white.opacity(opacityValue))
                }
                Text(formattedDate)
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color.white.opacity(opacityValue))
                Spacer()
            }
            .padding(.top, topPaddong)
            .padding(.horizontal, horizontalPadding)
            .zIndex(zValue)
            Spacer()
        }.offset(x: 0, y: topOffset)
    }
}
