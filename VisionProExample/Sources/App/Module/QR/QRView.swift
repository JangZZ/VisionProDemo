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
    @State private var amount: String = "500000000"

    var body: some View {
        VStack {
            PhotosPicker(
                selection: $selectedItem,
                matching: .images,
                photoLibrary: .shared()) {
                    Text("Select a photo")
                        .frame(width: 300, height: 80)
                        .font(.system(size: 30, weight: .bold))
                }
                .onChange(of: selectedItem, { oldValue, newValue in
                    Task {
                        // Retrieve selected asset in the form of Data
                        if let data = try? await newValue?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                })
                .padding(.top, 25)
                .padding(.bottom, 25)
            HStack(alignment: .top, content: {
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 400)
                    VStack {
                        Text("Thông tin chuyển khoản")
                            .font(.extraLargeTitle2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 16)
                        HStack {
                            Text("Bạn đang chuyển khoản tới:")
                                .font(.system(size: 25))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("VU QUANG ANH")
                                .font(.largeTitle)
                                .foregroundStyle(.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.bottom, 8)
                        HStack {
                            Text("Số tiền: ")
                                .font(.system(size: 25))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Số tiền",text: $amount)
                                .font(.largeTitle)
                                .foregroundStyle(.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .keyboardType(.numberPad)
                        }
                        .padding(.bottom, 24)
                        VStack(alignment: .trailing, content: {
                            HStack(alignment: .top, content: {
                                Image(.icAccountCard)
                                    .padding(.trailing, 16)
                                VStack {
                                    Text("Tài khoản thanh toán")
                                        .font(.system(size: 25, weight: .bold))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.bottom, 8)
                                    Text("686868686868")
                                        .font(.system(size: 25))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            })
                            .padding(.all, 16)
                            Divider()
                            Text("VND 80000000000")
                                .font(.system(size: 25, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.all, 16)
                                .multilineTextAlignment(.trailing)
                        })
                        .padding(.trailing, 16)
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white)
                            )
                    }
                }
            })
            .padding(.all, 8)
        }
    }
}

#Preview(windowStyle: .plain) {
    QRView()
}

