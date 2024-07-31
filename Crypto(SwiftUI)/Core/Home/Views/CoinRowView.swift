//
//  CoinRowView.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn : Bool
    
    var body: some View {
        
        HStack(spacing: 0){
            
            leftColumn
            
            Spacer()
            
            HStack{
                if showHoldingsColumn {
                    centerColumn
                }
                
                rightColumn
            }
            
        }
        .font(.subheadline)
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
        CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
}



extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            

            CoinImage(imageURL: coin.image)
                .frame(width: 30, height: 30)
                
            Text(coin.symbol.uppercased())
                .foregroundStyle(Color.theme.accent)
                .font(.headline)
                .padding(.leading, 6)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing){
            Text("\(coin.currentHoldingValue.asCurrencyWith2Decimals())")
                .bold()
            Text(coin.currentHolds?.asNumberString() ?? "0.0")
        }
        .foregroundStyle(.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(.accent)
            
            Text(coin.priceChangePercentage24H?.asPersentString() ?? "0.0%")
                .foregroundStyle(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
    
}
