//
//  CoinImageViewModel.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
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
