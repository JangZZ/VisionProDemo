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

        if sheetStack.count == 1 {
            currentSheet = sheet
        }
    }

    @MainActor
    func sheetDismissed() {
        sheetStack.removeFirst()

        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        }
    }
}

protocol SheetEnum: Identifiable {
    associatedtype Body: View
    
    @ViewBuilder var body: Body { get }
}

final class HomeNavigator: Navigatorable {

    enum Router: Routerable {
        case main
        case qrTransfer
        case accountAndCard
        case cardless
        case historyDetail(TransactionHistory)
        
        @ViewBuilder var body: some View {
            switch self {
            case .qrTransfer:
                QRView()
            case .historyDetail(_):
                HistoryDetail()
            default: 
                Text("Detail")
            }
        }
    }
    
    enum Sheet: SheetEnum {
        case historyDetail(TransactionHistory)
        
        var id: String { UUID().uuidString }
        
        @ViewBuilder var body: some View {
            switch self {
            case .historyDetail:
                HistoryDetail()
            }
        }
    }
    
    @Published var path: [Router] = []
    @Published var currentSheet: Sheet?
    var sheetStack: [Sheet] = []
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
            }
            // for sheet
            .sheet(item: $navigator.currentSheet) { sheet in
                sheet.body
            }
    }
}
