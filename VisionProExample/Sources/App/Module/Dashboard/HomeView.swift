//
//  ContentView.swift
//  VisionProExample
//
//  Created by Andy on 18/09/2023.
//

import SwiftUI
import Observation
import Charts

enum SideMenuItem: String, Hashable, CaseIterable {
    case home = "Dashboard"
    case message = "Message"
    case paymentRequest = "Payment requests"
    case findNewProduct = "Find a new product"
    case voucher = "Voucher"
    case settings = "Settings"
    case referEarn = "Refer & Earn"
}

struct ChartData {
    let count: Int
    let name: String
}

struct TransactionHistory {
    let transactionID: String
    let createdTime: String
    let balance: Double
    let providerName: String
    let message: String
    let fromAccount: Account
    let toAccount: Account
}

struct Account {
    let customerName: String
    let balance: Double
    let accountNumber: String
    let bankName: String
}

struct MainView: View {
    
    @State private var itemSelected: SideMenuItem = .home
    @State private var columnVisibility: NavigationSplitViewVisibility = .detailOnly
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            VStack(alignment: .leading) {
    
                VStack(alignment: .leading) {
                    Button {
                        columnVisibility = .detailOnly
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 15)
                    
                    Image(.icLogoTech)
                        .resizable()
                        .frame(width: 150, height: 20)
                    
                    Text("Hello,\nTRUONG HOANG NAM")
                        .font(.system(size: 20, weight: .bold))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 20)
                .padding(.bottom, 20)
                .padding(.top, 30)
                .background(.thinMaterial)
                
                List(SideMenuItem.allCases, id: \.self) { item in
                    Button(item.rawValue) {
                        itemSelected = item
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .navigationBarHidden(true)
        } detail: {
            detailContent
        }
        .navigationSplitViewStyle(.balanced)
    }
    
    @ViewBuilder var detailContent: some View {
        switch itemSelected {
        case .home: HomeView(columnVisibility: $columnVisibility)
        default: QRView()
        }
    }
}

struct HomeView: View {
    
    // MARK: - Properties
    @Environment(\.openWindow) var openWindow
    @State var path: [Router] =  []
    @Binding var columnVisibility: NavigationSplitViewVisibility
    
    var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(alignment: .trailing) {
                if columnVisibility == .detailOnly {
                    Button {
                        columnVisibility = .doubleColumn
                    } label: {
                        Image(systemName: "circle.grid.3x3.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .buttonStyle(.plain)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    
                } else {
                    Spacer()
                        .frame(height: 40)
                }
                
                Image(.icLogoTech)
                    .resizable()
                    .frame(width: 360, height: 48)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
                
                
                HStack {
                    actionsButton
                    
                    Spacer()
                    
                    currentBalance
                }
                .padding(.leading, 30)
                
                HStack(spacing: 30) {
                    historyView
                    
                    chartMoneyTracker
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)
            .padding(.top, 30)
            .navigationBarHidden(true)
        }
        .onAppear {
            vm.fetchHistory()
        }
    }
    
    @ViewBuilder var currentBalance: some View {
        HStack(spacing: 16) {
            Image(.icLogo)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Current Balance")
                    .font(.system(size: 30, weight: .light))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                
                Text("30,000,611,999")
                    .font(.system(size: 28, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 35)
        .background(.ultraThinMaterial)
        .clipShape(
            .rect(
                topLeadingRadius: 10,
                bottomLeadingRadius: 10,
                bottomTrailingRadius: 0,
                topTrailingRadius: 0,
                style: .continuous
            )
        )

    }
    
    @ViewBuilder var actionsButton: some View {
        HStack(spacing: 20) {
            buildMainButton(
                action: {
                    
                },
                title: "Accounts & Cards",
                image: Image(.icAccountCard)
            )
            
            buildMainButton(
                action: {
                    
                },
                title: "Move Money",
                image: Image(.icMoveMoney)
            )
            
            buildMainButton(
                action: {
                    openWindow(id: "QRWindow")
                },
                title: "Scan QR",
                image: Image(.icQr)
            )

            buildMainButton(
                action: {
                    
                },
                title: "Cardless withdraw",
                image: Image(.icCardless)
            )
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.white, lineWidth: 2)
        }
    }
    
    @ViewBuilder func buildMainButton(
        action: @escaping () -> Void,
        title: String,
        image: Image
    ) -> some View {
        Button {
            action()
        } label: {
            VStack {
                image
                Text(title)
            }
            .frame(width: 100, height: 100)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
        }
        .buttonStyle(.plain)
    }
    
    @ViewBuilder func buildHistoryView(_ history: TransactionHistory) -> some View {
        HStack(spacing: 20) {
            Image(history.balance > 0 ? "Money in" : "Money out")
            
            VStack(alignment: .leading, spacing: 10) {
                Text(history.toAccount.customerName)
                    .multilineTextAlignment(.leading)
                Text(history.message)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        
            Text(history.balance.convertToMoneyString())
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: true, vertical: true)
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder var historyView: some View {
        VStack {
            Text("Recent activities")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
            
            List(vm.history, id: \.transactionID) { history in
                buildHistoryView(history)
            }
        }
    }
    
    @ViewBuilder var chartMoneyTracker: some View {
        VStack {
            Text("Money Tracker")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
            
            chartView
        }
    }
    
    @ViewBuilder var chartView: some View {
        Chart {
            ForEach(vm.charts, id: \.name) { chart in
                BarMark(
                    x: .value("Name", chart.name),
                    y: .value("Count", chart.count)
                )
                .foregroundStyle(by: .value("Name", chart.name))
            }
        }
        .padding(.trailing, 30)
    }
}

enum Router {
    case main
    case qrTransfer
    case accountAndCard
    case cardless
}

#Preview(windowStyle: .plain) {
    HomeView(columnVisibility: .constant(.doubleColumn))
}
