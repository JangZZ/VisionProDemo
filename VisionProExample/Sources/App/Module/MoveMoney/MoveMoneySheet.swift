//
//  MoveMoneySheet.swift
//  VisionProExample
//
//  Created by Andy on 25/09/2023.
//

import SwiftUI

struct MoveMoneySheet: View {
    
    // MARK: - Properties
    @EnvironmentObject var navigator: HomeNavigator
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                navigator.sheetDismissed()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.plain)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 8)
            
            Text("TRANSFER")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal, 8)
            
            HStack(spacing: 12) {
                Image(.icShortcutTransferOthers)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .frame(width: 38, height: 38)
                    .background(.fill.tertiary)
                    .cornerRadius(19)
                
                VStack(spacing: 8) {
                    Text("To someone else")
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Transfer Napas 24/7, Internal, Interbank and to a securities account")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(8)
            .contentShape(.hoverEffect, .rect(cornerRadius: 8))
            .hoverEffect()
                    
            HStack(spacing: 12) {
                Image(.icShortcutTransferBetween)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .frame(width: 38, height: 38)
                    .background(.fill.tertiary)
                    .cornerRadius(19)
                
                Text("Between my TCB accounts")
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
            .contentShape(.hoverEffect, .rect(cornerRadius: 8))
            .hoverEffect()
            
            Text("PAYMENT")
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top, 16)
                .padding(.horizontal, 8)
            
            HStack(spacing: 12) {
                Image(.icToBill)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .frame(width: 38, height: 38)
                    .background(.fill.tertiary)
                    .cornerRadius(19)
                
                VStack(spacing: 8) {
                    Text("Bills and Top-up")
                        .font(.body)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Pay for mobile top-ups, electricity, water and more")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(8)
            .contentShape(.hoverEffect, .rect(cornerRadius: 8))
            .hoverEffect()
        }
        .padding(.vertical, 24)
        .padding(.horizontal, 10)
    }
}

#Preview {
    MoveMoneySheet()
}
