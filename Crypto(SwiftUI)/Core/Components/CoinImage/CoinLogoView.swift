//
//  CoinLogoView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 24/07/2024.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack{
            CoinImage(imageURL: coin.image)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: DeveloperPreview.instance.coin)
}
