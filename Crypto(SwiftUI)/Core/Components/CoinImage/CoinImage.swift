//
//  CoinImage.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import SwiftUI
import Combine

class CoinImageVM: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coinImageService: CoinImageService?
    private var cancellable = Set<AnyCancellable>()
    
    init(imageURL: String) {
        coinImageService = CoinImageService(urlString: imageURL)
        addSubscribers()
        isLoading = true
    }
    
    private func addSubscribers(){
        coinImageService?.$image
            .sink(receiveCompletion: { [weak self] (_) in
                self?.isLoading = false
            }, receiveValue: { [weak self] image in
                if let image = image {
                    self?.image = image
                }
            })
            .store(in: &cancellable)
    }
    
    
}

struct CoinImage: View {
    
    @StateObject var vm: CoinImageVM
    
    init(imageURL: String) {
        _vm = StateObject(wrappedValue: CoinImageVM(imageURL: imageURL))
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
    CoinImage(imageURL: "")
}
