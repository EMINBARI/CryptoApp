//
//  CandleChartWidget.swift
//  CandleChartWidget
//
//  Created by Emin Bari on 18.08.2020.
//

import WidgetKit
import SwiftUI

@main
struct Config: Widget {
    private let kind: String = "CandleChartWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: DataProvider()
        ) { data in
            MainWidgetView(data: data)
        }
        .configurationDisplayName(Text("Bitcoin stocks"))
        .supportedFamilies([.systemMedium])
        .description(Text("Current Bitcoin exchange rate"))
    }
}
