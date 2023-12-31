//
//  QRView.swift
//  VisionProExample
//
//  Created by Andy on 18/09/2023.
//

import SwiftUI
import PhotosUI

struct QRView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    @State private var amount: String = ""
    @State private var description: String = ""
    @State private var showingAccountList = false
    @EnvironmentObject var navigator: AppNavigator

    var body: some View {
        VStack {
            Image(.icLogoRed)
                .resizable()
                .frame(width: 250, height: 40, alignment: .leading)
                .frame(maxWidth: .infinity,  alignment: .leading)
            
            if selectedImageData == nil {
                imagePicker
                    .padding(.top, 16)
            }
            
            Spacer()
            
            if let selectedImageData,
               let uiImage = UIImage(data: selectedImageData) {
                HStack(alignment: .top, spacing: 45, content: {
                    VStack(spacing: 16) {
                        
                        HStack(spacing: 16) {
                            Image(.logoVietqrWhite)
                                .resizable()
                                .frame(width: 90, height: 30)
                            
                            Image(.logoNapasWhite)
                                .resizable()
                                .frame(width: 98, height: 30)

                            Image(.logoVnpayWhite)
                                .resizable()
                                .frame(width: 116, height: 30)
                        }
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        imagePicker
                    }
                    
                    infoView
                })
            } else {
                Spacer()
                
                Text("Share your QR code")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Image(.qrDemo)
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
            }
        }
        .padding(.top, 16)
        .padding([.horizontal, .bottom], 30)
    }
    
    @ViewBuilder var infoView: some View {
        VStack {
            Text("Thông tin chuyển khoản")
                .font(.extraLargeTitle2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 16)
            HStack {
                Text("Bạn đang chuyển khoản tới:")
                    .font(.system(size: 25, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("VU QUANG ANH")
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.bottom, 8)
            HStack {
                Text("Số tiền: ")
                    .font(.system(size: 25, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Số tiền",text: $amount)
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .keyboardType(.numberPad)
            }
            HStack {
                Text("Nội dung: ")
                    .font(.system(size: 25, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Nội dung",text: $description)
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .keyboardType(.default)
                    .submitLabel(.done)
                    .onSubmit {
                        navigator.push(to: .preview(description,
                                                    amount))
                    }

            }
            .padding(.bottom, 24)
            AccountView(onTap: {
                navigator.present(sheet: .accountList)
            })
        }
    }
    
    @ViewBuilder var imagePicker: some View {
        PhotosPicker(
            selection: $selectedItem,
            matching: .images,
            photoLibrary: .shared()) {
                HStack(spacing: 16) {
                    Image(systemName: "photo")
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                    
                    Text("Select a photo")
                        .font(.body)
                        .foregroundColor(.black)
                }
            }
            .onChange(of: selectedItem, { oldValue, newValue in
                Task {
                    // Retrieve selected asset in the form of Data
                    if let data = try? await newValue?.loadTransferable(type: Data.self) {
                        selectedImageData = data
                    }
                }
            })
    }
}

struct AccountView: View {
    
    var onTap: () -> ()

    var body: some View {
        VStack(alignment: .trailing, content: {
            HStack(alignment: .top, spacing: 16) {
                Image(.icAccountCard)
                VStack {
                    Text("Tài khoản thanh toán")
                        .font(.system(size: 25, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 3)
                    Text("686868686868")
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            
            Divider()
            
            Text("VND 80000000000")
                .font(.system(size: 25, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.all, 16)
                .multilineTextAlignment(.trailing)
        })
        .background(.black.opacity(0.2))
        .cornerRadius(16)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview(windowStyle: .plain) {
    QRView()
}

struct AccountListView: View {
    @EnvironmentObject var navigator: AppNavigator

    var body: some View {
        VStack(alignment: .trailing, spacing: 16, content: {
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
            .padding(.vertical, 16)
            
            AccountView(onTap: {
                navigator.sheetDismissed()
            })
            AccountView(onTap: {
                navigator.sheetDismissed()
            })
            AccountView(onTap: {
                navigator.sheetDismissed()
            })
        })
        .frame(width: 1000)
        .padding(.all, 50)
    }
}
