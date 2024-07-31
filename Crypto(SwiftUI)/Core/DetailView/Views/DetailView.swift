//
//  DetailView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 28/07/2024.
//

import SwiftUI

struct DetailView: View {
    
    let coin: CoinModel
    
    var body: some View {
        Text(coin.name)
            .bold()
            .font(.largeTitle)
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}
