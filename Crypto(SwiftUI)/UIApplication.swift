//
//  UIApplication.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 23/07/2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    /// Dismis keyboard
    /// ```
    /// UIApplication.shared.endEditing()
    /// ```
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
