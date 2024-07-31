//
//  ChartView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 30/07/2024.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startDate: Date
    private let endDate: Date
    @State private var percentage = 0.0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .theme.green : .theme.red
        endDate = Date(coinGekoString: coin.lastUpdated ?? "")
        startDate = endDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
            .overlay(alignment: .leading) { chartYAxis }
            
            chartDateLabels
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                withAnimation(.linear(duration: 2.0)) {
                    percentage = 1.0
                }
                
            })
        })
        
    }
}

extension ChartView {
    
    var chartView: some View {
        GeometryReader { geo in
            
            Path { path in
                for index in data.indices {
                    let xPosition = geo.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    let yAxis = maxY - minY
                    /* percentage of this point for all values and use this to get it position in y
                     lik if minY = 5000 and maxY = 6000 and this point is 5500 then 500 / 1000 = 0.5 so it should show in center of height
                        and 1 - this value because 0,0 is first point in top and 1000 is in the bottom in iphone so i will reverse my values
                     */
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geo.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke( lineColor, style: .init(lineWidth: 2, lineCap: .round , lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40)
            
        }
    }
    
    var chartBackground: some View {
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text((maxY - minY).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
        
    }
    
    var chartDateLabels: some View {
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endDate.asShortDateString())
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}
