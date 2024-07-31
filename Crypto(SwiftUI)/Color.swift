//
//  Color.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 17/07/2024.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launchTheme = LaunchTheme()
}


struct ColorTheme  {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenAppColor")
    let red = Color("RedAppColor")
    let secondaryText = Color("SecondaryTextColor")
}


struct LaunchTheme {
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
}
