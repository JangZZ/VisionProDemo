//
//  AccountCardViewModel.swift
//  VisionProExample
//
//  Created by Andy on 22/09/2023.
//

import Foundation
import Observation

@Observable
final class AccountCardViewModel {
    
    var accounts: [Account] = [
        .init(
            customerName: "TRUONG HOANG NAM",
            balance: 1_000_000_000,
            accountNumber: "88888888",
            bankName: "Techcombank"
        ),
        .init(
            customerName: "TRUONG HOANG NAM",
            balance: 3_000_000_000,
            accountNumber: "6666666666",
            bankName: "Techcombank"
        )
    ]
}

