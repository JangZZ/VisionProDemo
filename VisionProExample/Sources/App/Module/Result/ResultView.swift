//
//  ResultView.swift
//  VisionProExample
//
//  Created by anhvq on 26/09/2023.
//

import SwiftUI

struct ResultView: View {
    @State var message: String = ""
    @State var amount: String = ""
    @EnvironmentObject var navigator: AppNavigator

    var body: some View {
        VStack(alignment: .leading) {
            Image(.icLogoRed)
            Text("Successfully transferred")
                .font(.system(size: 30, weight: .bold))
                .padding(.bottom, 24)
            HStack {
                infoHView(title: "To: ", 
                          content: "Bui Minh Tu")
                Spacer()
                infoHView(title: "Amount: ", 
                          content: "VND \(amount)")
            }
            .padding(.bottom, 16)
            infoVView(title: "Recipent details",
                      content: "Join Stock Commercial Bank for Foreign Trade of Vietnam - VCB")
            .padding(.bottom, 8)
            infoVView(title: "Account number",
                      content: "0021 2400 8619 20")
            .padding(.bottom, 8)
            infoVView(title: "Message",
                      content: message)
            .padding(.bottom, 8)
            infoVView(title: "Transfer date",
                      content: "April 12, 2024")
            .padding(.bottom, 8)
            infoVView(title: "Transaction ID",
                      content: "FT0123123213123")
            .padding(.bottom, 16)
            Button(action: {
                navigator.popToRoot()
            }) {
                Text("Back to dashboard")
                    .frame(width: 800, height: 60)
            }

        }
        .padding(.all, 50)
    }
    
    @ViewBuilder func infoHView(title: String = "",
                               content: String = "") -> some View {
        HStack {
            Text(title)
                .font(.system(size: 25, weight: .bold))
            Text(content)
                .foregroundStyle(.blue)
                .font(.system(size: 25, weight: .bold))
        }
    }
    @ViewBuilder func infoVView(title: String = "",
                               content: String = "") -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 22, weight: .regular))
            Text(content)
                .font(.system(size: 25, weight: .bold))
        }
    }
}

#Preview(windowStyle: .plain) {
    ResultView()
}
