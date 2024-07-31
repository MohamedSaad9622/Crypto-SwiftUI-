//
//  Double.swift
//  Crypto(SwiftUI)
//
//  Created by Mohamed Saad on 18/07/2024.
//

import Foundation


extension Double {
    
    /// convert double to currency with 2 decimal places
    ///```
    ///convert this 1234.56 to $1,234.56
    ///convert this 12.3456 to $12.35
    ///convert this 0.123456 to $0.12
    ///
    ///```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
//        formatter.locale = .current // <- default
//        formatter.currencySymbol = "$"
//        formatter.currencyCode = "usd"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// convert double to currency as a string with 2 decimal places
    ///```
    ///convert this 1234.56 to "$1,234.56"
    ///convert this 12.3456 to "$12.35"
    ///convert this 0.123456 to "$0.12"
    ///
    ///```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number ) ?? "0.00"
    }
    
    /// convert double to currency with 2-6 decimal places
    ///```
    ///convert this 1234.56 to $1,234.56
    ///convert this 12.3456 to $12.3456
    ///convert this 0.123456 to $0.123456
    ///
    ///```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
//        formatter.locale = .current // <- default
//        formatter.currencySymbol = "$"
//        formatter.currencyCode = "usd"
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    /// convert double to currency as a string with 2-6 decimal places
    ///```
    ///convert this 1234.56 to "$1,234.56"
    ///convert this 12.3456 to "$12.3456"
    ///convert this 0.123456 to "$0.123456"
    ///
    ///```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number ) ?? "0.00"
    }
    
    /// convert double into string representation
    ///```
    ///convert this 1.23456 to "1.23"
    ///
    ///```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// convert double into string representation with percent symbol
    ///```
    ///convert this 1.23456 to "1.23%"
    ///
    ///```
    func asPersentString() -> String {
        return asNumberString() + "%"
    }
    
    /// Convert a Double to a String with K, M, Bn, Tr abbreviations.
    /// ```
    /// Convert 12 to 12.00
    /// Convert 1234 to 1.23K
    /// Convert 123456 to 123.45K
    /// Convert 12345678 to 12.34M
    /// Convert 1234567890 to 1.23Bn
    /// Convert 123456789012 to 123.45Bn
    /// Convert 12345678901234 to 12.34Tr
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""

        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)Bn"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted)K"
        case 0...:
            return self.asNumberString()

        default:
            return "\(sign)\(self)"
        }
    }

    
}
