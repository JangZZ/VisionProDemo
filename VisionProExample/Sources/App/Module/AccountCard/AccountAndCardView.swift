//
//  AccountAndCardView.swift
//  VisionProExample
//
//  Created by Andy on 22/09/2023.
//

import SwiftUI

struct AccountAndCardView: View {
    
    enum AccountType: String, CaseIterable {
        case account = "Accounts"
        case creditCards = "Credit Cards"
        case saveInvest = "Save & Invest"
        case loan = "Loan"
        case protect = "Protect"
    }
    
    @State private var accountIndexSelected: AccountType = .account
    @State private var vm = AccountCardViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("You own")
                    .font(.body)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                Text((vm.accounts.first?.balance.toMoneyString() ?? "VND 0"))
                    .font(.headline)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .background(.black.opacity(0.1))
            .cornerRadius(18)
            
            Picker("Account type", selection: $accountIndexSelected) {
                ForEach(AccountType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top, 24)
            
            accountListView
            
            Spacer()
        }
        .navigationTitle("Account & Card")
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder var accountListView: some View {
        List(vm.accounts) { account in
            VStack(alignment: .leading) {
                Text(account.customerName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 16) {
                    Image(.icAccountCard)
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    VStack {
                        Text("Current Account")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(account.accountNumber)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                Divider()
                
                Text(account.balance.toMoneyString())
                    .foregroundColor(.primary)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(16)
            .background(.black.opacity(0.1))
            .cornerRadius(18)
            .padding(.bottom, 20)
            .listRowInsets(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
            .contentShape(.hoverEffect, .rect(cornerRadius: 18))
        }
        .listStyle(.plain)
        .padding(.top, 8)
    }
}

#Preview {
    AccountAndCardView()
}
