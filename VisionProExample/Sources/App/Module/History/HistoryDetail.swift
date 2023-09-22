//
//  HistoryDetail.swift
//  VisionProExample
//
//  Created by Andy on 20/09/2023.
//

import SwiftUI

struct HistoryDetail: View {
    
    // MARK: - Properties
    var history: TransactionHistory
    @EnvironmentObject var navigator: HomeNavigator
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button {
                navigator.sheetDismissed()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Image(.icLogoRed)
                .resizable()
                .frame(width: 150, height: 20, alignment: .leading)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            Text(history.balance.toMoneyString())
                .font(.title)
                .foregroundColor(.black)
                .padding(.top, 25)
        
            Text(history.createdTime)
                .padding(.top, 5)
            
            Text("From account")
                .padding(.top, 25)
            
            Text(history.fromAccount.customerName)
                .font(.title)
                .foregroundColor(.black)
            
            Text(history.fromAccount.accountNumber)
                .padding(.top, 5)
            
            Text(history.fromAccount.bankName)
                .padding(.top, 5)
            
            Text("To account")
                .padding(.top, 25)
            
            Text(history.toAccount.customerName)
                .font(.title)
                .foregroundColor(.black)
            
            Text(history.toAccount.accountNumber)
                .padding(.top, 5)
            
            Text(history.toAccount.bankName)
                .padding(.top, 5)
            
            Text("Message")
                .padding(.top, 25)
            
            Text(history.message)
                .font(.body)
                .foregroundColor(.black)
            
            Text("Transaction ID: \(history.transactionID)")
                .font(.body)
                .padding(.top, 25)
                .foregroundColor(.black)
   
            Spacer()
                .frame(height: 30)
        }
        .padding(24)
    }
}

#Preview(windowStyle: .plain) {
    HistoryDetail(history: .mock)
}
