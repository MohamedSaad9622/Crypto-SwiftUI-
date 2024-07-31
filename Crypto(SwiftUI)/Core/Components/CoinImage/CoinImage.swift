//
//  CoinImage.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import SwiftUI

struct CoinImage: View {
    
    @StateObject var vm: CoinImageViewModel
    
    init(imageURL: String) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(imageURL: imageURL))
    }
    
    var body: some View {
        if let image = vm.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }else if vm.isLoading {
            ProgressView()
        }else{
            Image(systemName: "questionmark")
                .foregroundStyle(Color.theme.secondaryText)
        }
        
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImage(imageURL: DeveloperPreview.instance.coin.image)
}
