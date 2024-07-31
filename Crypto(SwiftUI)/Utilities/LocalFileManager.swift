//
//  LocalFileManager.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 19/07/2024.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    private init(){}
    
    private func saveImage (image: UIImage, urlString: String) {
        guard let data = image.pngData(), let url = URL(string: urlString) else {return}
        
        do {
            try data.write(to: url)
        }catch let error {
            print("Error in save image in fileManager \(error.localizedDescription)")
        }
        
    }
    
}
