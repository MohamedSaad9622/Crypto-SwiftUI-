//
//  CoinImageService.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    var imageSubscription: AnyCancellable?
    
    init(urlString: String){
        getImage(urlString: urlString)
    }
    
    func getImage(urlString: String) {
        guard let url = URL(string: urlString) else{return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion , receiveValue: { [weak self] image in
                self?.image = image
                self?.imageSubscription?.cancel()
            })
            
    }
    
}
