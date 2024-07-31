//
//  StatisticView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 24/07/2024.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: StatisticModel
     
    var body: some View {
        VStack(alignment: .leading,spacing: 4){
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(.accent)
            
            HStack(spacing: 4){
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0) >= 0 ?   0.0 :  180))
                
                Text(stat.percentageChange?.asPersentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(stat.percentageChange == nil ? 0.0 : 1)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: DeveloperPreview.instance.state3)
        .preferredColorScheme(.dark)
}

