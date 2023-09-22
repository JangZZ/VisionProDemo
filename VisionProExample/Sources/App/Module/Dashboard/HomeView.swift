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

struct TransactionHistory: Hashable {
    let transactionID: String
    let createdTime: String
    let balance: Double
    let providerName: String
    let message: String
    let fromAccount: Account
    let toAccount: Account
    
    static let mock: Self = .init(
        transactionID: "FT34343530034350BNK",
        createdTime: "10:20 17/09/2023",
        balance: -9000000,
        providerName: "",
        message: "NGUYEN VAN A chuyen tien",
        fromAccount: .init(
            customerName: "NGUYEN VAN A",
            balance: 30000000,
            accountNumber: "88888888",
            bankName: "Techcombank"
        ),
        toAccount: .init(
            customerName: "NGUYEN VAN B",
            balance: 4000000000,
            accountNumber: "666666666",
            bankName: "Vietcombank"
        )
    )
}

struct Account: Hashable {
    let customerName: String
    let balance: Double
    let accountNumber: String
    let bankName: String
}

struct MainView: View {
    
    // MARK: - Properties
    @State private var itemSelected: SideMenuItem = .home
    @State private var columnVisibility: NavigationSplitViewVisibility = .detailOnly
    @StateObject private var homeNavigator = HomeNavigator()
    
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
                .environmentObject(homeNavigator)
        default: QRView()
        }
    }
}

struct HomeView: View {
    
    // MARK: - Properties
    @Environment(\.openWindow) var openWindow
    @EnvironmentObject var navigator: HomeNavigator
    @Binding var columnVisibility: NavigationSplitViewVisibility
    @State var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $navigator.path) {
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
                    .hoverEffect()
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
                
                currentBalance
                
                HStack(spacing: 30) {
                    historyView
                    
                    chartMoneyTracker
                }
                .padding(.top, 16)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 16)
            .padding(.top, 30)
            .navigationBarHidden(true)
            .navigate(by: navigator)
        }
        .onAppear {
            vm.fetchHistory()
        }
        .ornament(
            attachmentAnchor: .scene(.bottom),
            contentAlignment: .center
        ) {
            actionsButton
        }
    }
    
    @ViewBuilder var currentBalance: some View {
        HStack(spacing: 16) {
            Image(.icLogo)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Current Balance")
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                
                Text("30,000,611,999")
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(.fill.tertiary)
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
        HStack(spacing: 16) {
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
        .padding(12)
        .glassBackgroundEffect(in: .rect(cornerRadius: 12))
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
                    .font(.system(size: 12))
            }
            .frame(width: 120, height: 44)
            .padding(16)
        }
        .buttonStyle(FunFactButtonStyle())
    }
    
    @ViewBuilder func buildHistoryView(_ history: TransactionHistory) -> some View {
        HStack(spacing: 20) {
            Image(systemName: history.balance > 0 ? "arrow.down.left.square.fill" : "arrow.up.forward.app.fill")
                .foregroundColor(history.balance > 0 ? .green : .black)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(history.toAccount.customerName)
                    .multilineTextAlignment(.leading)
                Text(history.message)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
        
            Text(history.balance.toMoneyString(isHiddenCurrent: true))
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .fixedSize(horizontal: true, vertical: true)
                .multilineTextAlignment(.trailing)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            navigator.present(sheet: .historyDetail(history))
        }
    }
    
    @ViewBuilder var historyView: some View {
        VStack {
            Text("Recent activities")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 40)
            
            List(vm.history, id: \.transactionID) { history in
                buildHistoryView(history)
            }
        }
        .padding(.leading, 10)
    }
    
    @ViewBuilder var chartMoneyTracker: some View {
        VStack {
            Text("Money Tracker")
                .font(.title)
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
                .cornerRadius(10, style: .continuous)
            }
        }
        .padding(.trailing, 30)
    }
}

#Preview(windowStyle: .plain) {
    HomeView(columnVisibility: .constant(.doubleColumn))
}

struct FunFactButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(.regularMaterial, in: .rect(cornerRadius: 12))
            .hoverEffect()
    }
}
