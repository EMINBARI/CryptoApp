//
//  Chart.swift
//  CryptoApp
//
//  Created by Emin Bari on 18.08.2020.
//

import SwiftUI

struct Chart: View {
    
    func degreeHeight(_ height: CGFloat, range: Int) -> CGFloat {
      height / CGFloat(range)
    }
    
    func dayWidth(_ width: CGFloat, count: Int) -> CGFloat {
      width / CGFloat(count)
    }
    
    func dayOffset(_ date: Date, dWidth: CGFloat) -> CGFloat {
      CGFloat(Calendar.current.ordinality(of: .day, in: .year, for: date)!) * dWidth
    }
    
    func tempOffset(_ temperature: Double, degreeHeight: CGFloat) -> CGFloat {
      CGFloat(temperature + 10) * degreeHeight
    }
    
    func tempLabelOffset(_ line: Int, height: CGFloat) -> CGFloat {
      height - self.tempOffset(Double(line * 10),
                               degreeHeight: self.degreeHeight(height, range: 110))
    }
    
    var body: some View {
        GeometryReader { reader in            
            ForEach(measurements, id: \.self) { measurement in
              // 2
              Path { p in
                // 3
                let dWidth = self.dayWidth(reader.size.width, count: 20)
                let dHeight = self.degreeHeight(reader.size.height, range: 60)
                // 4
                let dOffset = CGFloat(measurement.id * 10)
                // 5
               
                let lowOffsetB = self.tempOffset(measurement.min, degreeHeight: dHeight)
                let highOffsetB = self.tempOffset(measurement.max, degreeHeight: dHeight)
                // 6
                p.move(to: .init(x: dOffset, y: reader.size.height - lowOffsetB))
                p.addLine(to: .init(x: dOffset, y: reader.size.height - highOffsetB))
                // 7
              }.stroke(Color.green, lineWidth: 6)
            }
        }
    }//View
}

//struct Chart_Previews: PreviewProvider {
//    static var previews: some View {
//        Chart()
//    }
//}
