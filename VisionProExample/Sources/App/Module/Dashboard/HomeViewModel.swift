//
//  HomeViewModel.swift
//  VisionProExample
//
//  Created by Andy on 19/09/2023.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    
    // MARK: - Properties
    var history: [TransactionHistory] = []
    var historySelected: TransactionHistory!
    
    var charts: [ChartData] = [
        .init(count: 700, name: "Money In"),
        .init(count: 300, name: "Money Out"),
        .init(count: 1000, name: "Savings"),
    ]
    
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
    
    func fetchHistory() {
        history = [
            .init(
                transactionID: "FT34343530034344BNK",
                createdTime: "10:20 17/09/2023",
                balance: -5000000,
                providerName: "",
                message: "NGUYEN VAN A chuyen tien",
                fromAccount: .init(
                    customerName: "NGUYEN VAN A",
                    balance: 30000000,
                    accountNumber: "88888888",
                    bankName: "Techcombank"
                ),
                toAccount: .init(
                    customerName: "NGUYEN VAN B",
                    balance: 4000000000,
                    accountNumber: "666666666",
                    bankName: "Vietcombank"
                )
            ),
            .init(
                transactionID: "FT34343530034347xBNK",
                createdTime: "10:20 17/09/2023",
                balance: 10000000,
                providerName: "",
                message: "NGUYEN VAN A chuyen tien",
                fromAccount: .init(
                    customerName: "NGUYEN VAN A",
                    balance: 30000000,
                    accountNumber: "88888888",
                    bankName: "Techcombank"
                ),
                toAccount: .init(
                    customerName: "NGUYEN VAN B",
                    balance: 4000000000,
                    accountNumber: "666666666",
                    bankName: "Vietcombank"
                )
            ),
            .init(
                transactionID: "FT34343530034348BNK",
                createdTime: "10:20 17/09/2023",
                balance: 7500000,
                providerName: "",
                message: "NGUYEN VAN A chuyen tien",
                fromAccount: .init(
                    customerName: "NGUYEN VAN A",
                    balance: 30000000,
                    accountNumber: "88888888",
                    bankName: "Techcombank"
                ),
                toAccount: .init(
                    customerName: "NGUYEN VAN B",
                    balance: 4000000000,
                    accountNumber: "666666666",
                    bankName: "Vietcombank"
                )
            ),
            .init(
                transactionID: "FT34343530034349BNK",
                createdTime: "10:20 17/09/2023",
                balance: -50000000,
                providerName: "",
                message: "NGUYEN VAN A chuyen tien",
                fromAccount: .init(
                    customerName: "NGUYEN VAN A",
                    balance: 30000000,
                    accountNumber: "88888888",
                    bankName: "Techcombank"
                ),
                toAccount: .init(
                    customerName: "NGUYEN VAN B",
                    balance: 4000000000,
                    accountNumber: "666666666",
                    bankName: "Vietcombank"
                )
            ),
            .init(
                transactionID: "FT34343530034350BNK",
                createdTime: "10:20 17/09/2023",
                balance: -9000000,
                providerName: "",
                message: "NGUYEN VAN A chuyen tien",
                fromAccount: .init(
                    customerName: "NGUYEN VAN A",
                    balance: 30000000,
                    accountNumber: "88888888",
                    bankName: "Techcombank"
                ),
                toAccount: .init(
                    customerName: "NGUYEN VAN B",
                    balance: 4000000000,
                    accountNumber: "666666666",
                    bankName: "Vietcombank"
                )
            )
            
        ]
    }
}
