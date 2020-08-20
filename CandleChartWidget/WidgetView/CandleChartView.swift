//
//  CandleChart.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import SwiftUI

struct CandleChartView: View {
    
    var data: [CryptoData]
    let maxValue: Double
    let minValue: Double
    
    let candelSpacing: CGFloat = 14
    let scale: CGFloat = 1000
    
    let shadowBarWidth: CGFloat = 2.4
    let shadowBarColor: Color = Color.white.opacity(0.9)
    let bodyBarWidth: CGFloat = 8
    let bodyBullColor: Color = Color.green
    let bodyBearColor: Color = Color.red
    
    let gridColor: Color = Color.white.opacity(0.5)
    let labelColor: Color = Color.white.opacity(0.25)
    let labelVerticalOffset: CGFloat = 8
    let gridLeftPadding: CGFloat = 15
    
    var dataCount: CGFloat {
        get{
            CGFloat(data.count)
        }
    }
    
    var range: Int {
        get{
            return Int(2 * maxValue)
        }
    }
    
    func getScaleProportion(height: CGFloat) -> CGFloat{
        height / CGFloat(range)
    }
    
    //MARK:- Horizontal offset value for each candle bar
    func xOffset(_ date: Date) -> CGFloat {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: date)
        let daysCount: CGFloat = CGFloat(components.day!)
        
        return (dataCount - abs(daysCount)) * candelSpacing
    }
    
    //MARK:- Vertical offset value for each candle bar
    func yOffset(_ currencyScale: Double, degreeHeight: CGFloat) -> CGFloat {
        CGFloat(currencyScale) * degreeHeight
    }
    
    func labelOffset(_ line: Int, height: CGFloat) -> CGFloat {
        height - self.yOffset(
            Double(line) * Double(scale),
            degreeHeight: self.getScaleProportion(height: height))
    }

    func gridLinesOffsetUnit(height: CGFloat, line: Int) -> CGFloat {
        let n = getScaleProportion(height: height)
        let offset = (CGFloat(line) * scale)
        return height - offset * n
    }
 
    var body: some View {
        GeometryReader { reader in
            
            //MARK:- Grid lines
            ForEach(1..<18) { line in
                Group {
                    Path { path in
                        let y = self.gridLinesOffsetUnit(height: reader.size.height, line: line)
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: reader.size.width - gridLeftPadding, y: y))
                    }.stroke(labelColor)
                    
                    Text("\(line)K")
                        .font(.caption2)
                        .offset(
                            x: reader.size.width - gridLeftPadding,
                            y: self.labelOffset(line, height: reader.size.height) - labelVerticalOffset)
                        .foregroundColor(gridColor)
                }
            }
            
            //MARK:- Shadow bars (max and min values)
            ForEach(data, id: \.date) { measurement in
                Path { p in
                    let dHeight = self.getScaleProportion(height: reader.size.height)
                    let dOffset = self.xOffset(Date.getDateFromString(measurement.date))
                    
                    let lowOffset = self.yOffset(measurement.highPrice, degreeHeight: dHeight)
                    let highOffset = self.yOffset(measurement.lowPrice, degreeHeight: dHeight)
                    
                    p.move(to: .init(x: dOffset , y: reader.size.height - lowOffset))
                    p.addLine(to: .init(x: dOffset , y: reader.size.height - highOffset))
                }.stroke(shadowBarColor, lineWidth: shadowBarWidth)
            }
            
            //MARK:- Body bars (open and close values)
            ForEach(data, id: \.date) { measurement in
                var isBull = false
                Path { p in

                    if measurement.closePrice > measurement.openPrice {
                        isBull = true
                    }
                    
                    let dHeight = self.getScaleProportion(height: reader.size.height)
                    let dOffset = self.xOffset(Date.getDateFromString(measurement.date))

                    let lowOffset = self.yOffset(measurement.closePrice, degreeHeight: dHeight)
                    let highOffset = self.yOffset(measurement.openPrice, degreeHeight: dHeight)

                    p.move(to: .init(x: dOffset, y: reader.size.height - lowOffset))
                    p.addLine(to: .init(x: dOffset, y: reader.size.height - highOffset))
                }.stroke(
                    isBull ? bodyBullColor : bodyBearColor,
                    lineWidth: bodyBarWidth)
            }//Foreach
        }//GeometryReader
    }
}

