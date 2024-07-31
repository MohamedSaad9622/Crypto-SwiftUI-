//
//  HomeStatsView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 24/07/2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPortoflio: Bool
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .center) {
                ForEach(vm.statistics) { stat in
                    StatisticView(stat: stat)
                        .frame(width: geo.size.width / 3)
                }
            }
            .frame( width: geo.size.width , alignment: showPortoflio ? .trailing : .leading)
        }
        .frame(height: 80)
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HomeStatsView(showPortoflio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeVM)
}
