//
//  GetDateFromString.swift
//  CryptoApp
//
//  Created by Emin Bari on 20.08.2020.
//

import Foundation

extension Date {
    static func getDateFromString(_ dateStr: String ) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateStr) else {return Date()}
        return date
    }
}
