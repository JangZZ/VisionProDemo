//
//  ConfirmView.swift
//  VisionProExample
//
//  Created by anhvq on 26/09/2023.
//

import SwiftUI

struct ConfirmView: View {
    @State var message: String = ""
    @State var amount: String = ""
    @EnvironmentObject var navigator: AppNavigator

    var body: some View {
        VStack(spacing: 8) {
            Image(.icLogoRed)
                .resizable()
                .frame(width: 250, height: 40, alignment: .leading)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            Text("Transfer VND \(amount)")
                .font(.extraLargeTitle2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 24)
            
            infoView(title: "To",
                     name: "BUI MINH TU",
                     content: "1900 2222 3333 99\nJoint Stock Commercial Bank for Foreign Trade of Vietnam")
            .padding(.bottom, 24)
            infoView(title: "From",
                     name: "Current Account",
                     content: "888888888")
            VStack(alignment: .leading) {
                HStack {
                    Text("Message: ")
                        .font(.system(size: 25, weight: .bold))
                    Text(message)
                        .foregroundStyle(.blue)
                        .font(.system(size: 22, weight: .bold))
                }
                
                HStack {
                    Text("Transfer fee: ")
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.leading)
                    
                    Text("VND 0")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(.blue)
                }
            }
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                navigator.present(sheet: .result(message, amount))
            }) {
                Text("Confirm")
                    .frame(width: 200, height: 60)
            }
            .padding(.top, 24)
        }
        .padding(.all, 30)
    }
    
    @ViewBuilder func infoView(title: String = "",
                               name: String = "",
                               content: String = "") -> some View {
        VStack {
            Text(title)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .top, spacing: 16) {
                Image(.icLogo)
                    .iconified(imageSize: 40, surroundSize: 60, color: .white)
                VStack {
                    Text(name)
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                
            }
        }
    }
}

#Preview(windowStyle: .plain) {
    ConfirmView()
}

extension Image {
  func iconified(imageSize: Double, surroundSize: Double, color: Color) -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: imageSize, height: imageSize)
      .frame(width: surroundSize, height: surroundSize)
      .background(color)
      .clipShape(Circle())
  }
}
