//
//  DateFormatter.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

