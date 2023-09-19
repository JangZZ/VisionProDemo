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
    @State private var columnVisibility: NavigationSplitViewVisibility = .doubleColumn
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            VStack(alignment: .leading) {
    
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        
                        Button { 
                            columnVisibility = .detailOnly
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .buttonStyle(.plain)
                        .padding(.trailing, 15)
                    }
                    .frame(height: 30)
                    
                    Image(.icLogoTech)
                        .resizable()
                        .frame(width: 100, height: 20)
                    
                    HStack {
                        Text("Hello,\nTRUONG HOANG NAM")
                            .font(.system(size: 20, weight: .bold))
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 20)
                .padding(.bottom, 20)
                .background(.thinMaterial)
                
                List(SideMenuItem.allCases, id: \.self) { item in
                    Button(item.rawValue) {
                        itemSelected = item
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        } detail: {
            detailContent
        }
        .navigationSplitViewStyle(.balanced)
    }
    
    @ViewBuilder var detailContent: some View {
        switch itemSelected {
        case .home: HomeView(columnVisibility: $columnVisibility)
        default: Text("OKOK")
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
                    HStack {
                        Button {
                            columnVisibility = .doubleColumn
                        } label: {
                            Image(systemName: "circle.grid.3x3.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .frame(height: 50)
                    .padding(.horizontal, 45)
                } else {
                    EmptyView()
                        .frame(height: 50)
                }
                
                HStack {
                    Image(.icLogoTech)
                        .resizable()
                        .frame(width: 360, height: 48)
                        .padding(.horizontal, 45)
                        .padding(.top, 30)
                        .padding(.bottom, 16)
                    
                    Spacer()
                }
                
                
                HStack {
                    actionsButton
                    
                    Spacer()
                    
                    currentBalance
                }
                .padding(.leading, 45)
                
                HStack(spacing: 30) {
                    historyView
                    
                    chartMoneyTracker
                }
                .padding(.top, 30)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 30)
        }
        .onAppear {
            vm.fetchHistory()
        }
    }
    
    @ViewBuilder var currentBalance: some View {
        HStack(spacing: 16) {
            Image(.icLogo)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Current Balance")
                    .font(.system(size: 30, weight: .light))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                
                Text("3,611,999")
                    .font(.system(size: 28, weight: .medium))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
        }
        .padding(.leading, 34)
        .padding(.vertical, 16)
        .padding(.trailing, 20)
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
                title: "Accounts & Cards",
                image: Image(.icAccountCard)
            )
            
            buildMainButton(
                title: "Move Money",
                image: Image(.icMoveMoney)
            )
            
            buildMainButton(
                title: "Scan QR",
                image: Image(.icQr)
            )

            buildMainButton(
                title: "Cardless withdraw",
                image: Image(.icCardless)
            )
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 40)
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.white, lineWidth: 2)
        }
    }
    
    @ViewBuilder func buildMainButton(
        title: String,
        image: Image
    ) -> some View {
        Button {
            
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
                .padding(.leading, 25)
            
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
                .padding(.leading, 25)
            
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
