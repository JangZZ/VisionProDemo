//
//  HomeNavigator.swift
//  VisionProExample
//
//  Created by Andy on 20/09/2023.
//

import Foundation
import SwiftUI

protocol Routerable: Hashable {
    associatedtype Body: View
    
    @ViewBuilder var body: Body { get }
}

protocol Navigatorable: ObservableObject, AnyObject {
    associatedtype Router: Routerable
    associatedtype SheetType: SheetEnum
    
    var path: [Router] { get set }
    func push(to target: Router)
    
    func popToRoot()
    
    func pop()
    
    func pop(to target: Router)
    
    // Sheet
    var currentSheet: SheetType? { get set }
    
    var sheetStack: [SheetType] { get set }
    
    func present(sheet: SheetType)
    
    func sheetDismissed()
}

extension Navigatorable {
    
    @MainActor
    func push(to target: Router) {
        path.append(target)
    }
    
    @MainActor
    func popToRoot() {
        currentSheet = nil
        path = []
    }
    
    @MainActor
    func pop() {
        path.removeLast()
    }
    
    @MainActor
    func pop(to target: Router) {
        if let index = path.firstIndex(of: target) {
            path = Array(path.prefix(index + 1))
        }
    }
    
    @MainActor
    func present(sheet: SheetType) {
        sheetStack.append(sheet)

        currentSheet = sheet
    }

    @MainActor
    func sheetDismissed() {
        currentSheet = nil
    }
}

protocol SheetEnum: Identifiable {
    associatedtype Body: View
    
    @ViewBuilder var body: Body { get }
}

final class AppNavigator: Navigatorable {
    
    @Published var path: [Router] = []
    @Published var currentSheet: Sheet?
    var sheetStack: [Sheet] = []
}

// Routers
extension AppNavigator {
    enum Router: Routerable {
        case main
        case qrTransfer
        case accountAndCard
        case cardless
        case historyDetail(TransactionHistory)
        case preview(String, String)
        case result(String, String)
        
        @ViewBuilder var body: some View {
            switch self {
            case .qrTransfer:
                QRView()
                
            case .historyDetail(let history):
                HistoryDetail(history: history)
                
            case .accountAndCard:
                AccountAndCardView()
                
            case .cardless:
                CardLessView()
            
            case .preview(let message, let amount):
                ConfirmView(message: message, amount: amount)
                
            case .result(let message, let amount):
                ResultView(message: message, amount: amount)
    
            default:
                Text("Detail")
            }
        }
    }
}

// Sheets
extension AppNavigator {
    enum Sheet: SheetEnum {
        case historyDetail(TransactionHistory)
        case moveMoney
        case accountList
        case preview
        case result(String, String)
        
        var id: String { UUID().uuidString }
        
        @ViewBuilder var body: some View {
            switch self {
            case .historyDetail(let history):
                HistoryDetail(history: history)
                
            case .moveMoney:
                MoveMoneySheet()
                
            case .accountList:
                AccountListView()
            
            case .result(let message, let amount):
                ResultView(message: message, amount: amount)
                
            case .preview:
                MoveMoneySheet()
            }
        }
    }
    
}

extension View {
    func navigate<N: Navigatorable>(by navigator: N) -> some View {
        return modifier(NavigatorModifer(navigator: navigator))
    }
}

struct NavigatorModifer<N: Navigatorable>: ViewModifier {
    
    // MARK: - Properties
    @StateObject var navigator: N
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: N.Router.self) { router in
                router.body
                    .environmentObject(navigator)
            }
            // for sheet
            .sheet(item: $navigator.currentSheet) { sheet in
                sheet.body
                    .environmentObject(navigator)
            }
    }
}
