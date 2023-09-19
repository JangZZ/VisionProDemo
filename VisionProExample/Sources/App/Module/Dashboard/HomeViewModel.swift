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
    
    var charts: [ChartData] = [
        .init(count: 100, name: "Money In"),
        .init(count: 300, name: "Money Out"),
        .init(count: 1000, name: "Savings"),
    ]
    
    func fetchHistory() {
        history = [
            .init(
                transactionID: "FT34343530034344BNK",
                createdTime: "10:20 17/09/2023",
                balance: 500000,
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
                transactionID: "FT34343530034344BNK",
                createdTime: "10:20 17/09/2023",
                balance: 500000,
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
                transactionID: "FT34343530034344BNK",
                createdTime: "10:20 17/09/2023",
                balance: 500000,
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
                transactionID: "FT34343530034344BNK",
                createdTime: "10:20 17/09/2023",
                balance: -500000,
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
                transactionID: "FT34343530034344BNK",
                createdTime: "10:20 17/09/2023",
                balance: -500000,
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
