//
//  Double+Ext.swift
//  VisionProExample
//
//  Created by Andy on 19/09/2023.
//

import Foundation

extension Double {
    func toMoneyString(isHiddenCurrent: Bool = false) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currencyISOCode
        currencyFormatter.paddingPosition = .afterPrefix
        currencyFormatter.currencyCode = "VND"
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale(identifier: "en_US")

        // We'll force unwrap with the !, if you've got defined data you may need more error checking

        let money = currencyFormatter.string(from: NSNumber(value: self))!
        
        if isHiddenCurrent {
            return money.replacingOccurrences(of: "VND", with: "")
        } else {
            return money
        }
    }
    
    func formatLargeMoney(
        numberOfFraction: Int,
        isHandleK: Bool = false,
        roundMode: FloatingPointRoundingRule? = nil
    ) -> String {
        let num = abs(self)
        let sign = (self < 0) ? "-" : ""
        let lang = "en"
        
        let formatted: Double
        let unit: String
        
        switch num {
        case 1_000_000_000_000...:
            formatted = num / 1_000_000_000_000
            unit = lang == "en" ? "T" : " N. Tỷ"
        case 1_000_000_000...:
            formatted = num / 1_000_000_000
            unit = lang == "en" ? "B" : " Tỷ"
        case 1_000_000...:
            formatted = num / 1_000_000
            unit = lang == "en" ? "M" : " Tr"
        case 1_000...:
            if isHandleK {
                formatted = num / 1_000
                unit = lang == "en" ? "K" : " K"
            } else {
                formatted = num
                unit = ""
            }
        case 0:
            return "0"
        default:
            formatted = num
            unit = ""
        }
        
        let nf = NumberFormatter()
        nf.roundingMode = .down
        nf.groupingSeparator = ","
        nf.groupingSize = 3
        nf.numberStyle = .decimal
        nf.usesGroupingSeparator = true
        nf.decimalSeparator = "."
        nf.maximumFractionDigits = numberOfFraction
        
        if let roundMode {
            if let number = nf.string(from: NSNumber(value: formatted.roundedToPlaces(places: numberOfFraction, rule: roundMode))) {
                return sign + number + unit
            }
        } else {
            if let number = nf.string(from: NSNumber(value: formatted.roundedToPlaces(places: 2))) {
                return sign + number + unit
            }
        }
        
        return ""
    }
    
    func roundedToPlaces(places: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded(rule) / divisor
    }
}
