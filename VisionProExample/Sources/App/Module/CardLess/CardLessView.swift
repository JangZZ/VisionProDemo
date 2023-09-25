//
//  CardLessView.swift
//  VisionProExample
//
//  Created by Andy on 25/09/2023.
//

import SwiftUI

struct CardLessView: View {
    
    @State private var amount: String = ""
    
    var body: some View {
        VStack {
            Image(.icLogoRed)
                .resizable()
                .frame(width: 250, height: 40, alignment: .leading)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            Text("I want to withdraw at Techcombank ATM VND")
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("amount", text: $amount)
                .font(.title)
            
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("Your amount must be a multiple of VND 50,000. You can withdraw a maximum of VND 20 million per transaction and VND 50 million per day")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 16)
            
            Spacer()
            
            AccountView()
                .padding(.top, 20)
        }
        .padding(.top, 16)
        .padding([.horizontal, .bottom], 30)
    }
}

#Preview {
    CardLessView()
}
