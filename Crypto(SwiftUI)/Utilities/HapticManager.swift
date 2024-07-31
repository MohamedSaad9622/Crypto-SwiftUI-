//
//  HapticManager.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 28/07/2024.
//

import Foundation
import SwiftUI


class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
