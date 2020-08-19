//
//  CandleChart.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import SwiftUI

struct CandleChartView: View {
    
    var data: [CryptoData]
    
    func degreeHeight(_ height: CGFloat, range: Int) -> CGFloat {
        height / CGFloat(range)
    }
    
    func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
        width  / CGFloat(count)
    }
    
    func dayOffset(_ date: Date) -> CGFloat {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: date)
        guard let daysCount: CGFloat = CGFloat(components.day!) else {return 0}
        
        return (22 - abs(daysCount)) * 13
    }
    
    func tempOffset(_ temperature: Double, degreeHeight: CGFloat) -> CGFloat {
        CGFloat(temperature) * degreeHeight
    }
    
    func tempLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
        height - self.tempOffset(Double(line * 10), degreeHeight: self.degreeHeight(height, range: 110))
    }
    
//    var body: some View {
//        GeometryReader { reader in
//            ForEach(measurements, id: \.self) { measurement in
//                Path { p in
//                    let dHeight = self.degreeHeight(reader.size.height, range: 10)
////                    let dOffset = CGFloat(measurement.id * 10)
//                    let dOffset = self.dayOffset(getDate(measurement.date))
//
//                    let lowOffset = self.tempOffset(measurement.highPrice*1, degreeHeight: dHeight)
//                    let highOffset = self.tempOffset(measurement.lowPrice*1, degreeHeight: dHeight)
//
//                    p.move(to: .init(x: dOffset, y: reader.size.height - lowOffset))
//                    p.addLine(to: .init(x: dOffset, y: reader.size.height - highOffset))
//
//                }.stroke(Color.blue, lineWidth: 2)
//            }
//
//            ForEach(measurements, id: \.self) { measurement in
//                Path { p in
//                  let dHeight = self.degreeHeight(reader.size.height, range: 10)
//
////                  let dOffset = CGFloat(measurement.id * 10)
//                    let dOffset = self.dayOffset(getDate(measurement.date))
//
//                  let lowOffsetB = self.tempOffset(measurement.min*1, degreeHeight: dHeight)
//                  let highOffsetB = self.tempOffset(measurement.max*1, degreeHeight: dHeight)
//
//                  p.move(to: .init(x: dOffset, y: reader.size.height - lowOffsetB))
//                  p.addLine(to: .init(x: dOffset, y: reader.size.height - highOffsetB))
//                }.stroke(Color.green, lineWidth: 6)
//            }//Foreach
//        }//GeometryReader
//    }
    
    
    var body: some View {
        GeometryReader { reader in
            
            //MARK:- horizontal grid lines
            ForEach(-1..<11) { line in
              Group {
                Path { path in
                  let y = self.tempLabelOffset(line, height: reader.size.height)
                  path.move(to: CGPoint(x: 0, y: y))
                  path.addLine(to: CGPoint(x: reader.size.width - 15, y: y))
                }.stroke(line == 0 ? Color.black : Color.white.opacity(0.3))
                if line >= 0 {
                  Text("\(line)K")
                    .font(.caption2)
                    .offset(x: reader.size.width - 15, y: self.tempLabelOffset(line, height: reader.size.height) - 8)
                    .foregroundColor(Color.white.opacity(0.5))
                }
              }
            }
            
            ForEach(data, id: \.date) { measurement in
                Path { p in
                    print("-",measurement.date)
                    let dHeight = self.degreeHeight(reader.size.height, range: 23539)
                    let dOffset = self.dayOffset(getDate(measurement.date))
                    
                    let lowOffset = self.tempOffset(measurement.highPrice, degreeHeight: dHeight)
                    let highOffset = self.tempOffset(measurement.lowPrice, degreeHeight: dHeight)
                    
                    p.move(to: .init(x: dOffset + 10, y: 3 * ( reader.size.height - lowOffset*1.7)))
                    p.addLine(to: .init(x: dOffset + 10 , y: 3 * (reader.size.height - highOffset*1.7)))
                    
                }.stroke(Color.white.opacity(0.9), lineWidth: 2.4)
            }
            
            ForEach(data, id: \.date) { measurement in
                var isBull = false
                Path { p in

                    if measurement.closePrice > measurement.openPrice {
                        isBull = true
                    }
                    
                    let dHeight = self.degreeHeight(reader.size.height, range: 23539)
                    let dOffset = self.dayOffset(getDate(measurement.date))

                    let lowOffsetB = self.tempOffset(measurement.closePrice, degreeHeight: dHeight)
                    let highOffsetB = self.tempOffset(measurement.openPrice, degreeHeight: dHeight)

                    p.move(to: .init(x: dOffset + 10, y: 3 * ( reader.size.height - lowOffsetB * 1.7)))
                    p.addLine(to: .init(x: dOffset + 10, y: 3 * (reader.size.height - highOffsetB * 1.7)))
                }.stroke(
                    isBull ? Color.green : Color.red,
                    lineWidth: 8)
            }//Foreach
            
        }//GeometryReader
    }
}

func getDate(_ dateStr: String ) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = dateFormatter.date(from: dateStr) else {return Date()}
    return date
}
