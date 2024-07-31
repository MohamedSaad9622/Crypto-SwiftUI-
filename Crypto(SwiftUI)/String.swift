//
//  String.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 30/07/2024.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
