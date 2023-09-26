//
//  QrNavigator.swift
//  VisionProExample
//
//  Created by anhvq on 26/09/2023.
//

import SwiftUI

final class QrNavigator: Navigatorable {

    enum Router: Routerable {
        case accountList
        case preview
        
        @ViewBuilder var body: some View {
            switch self {
            case .accountList:
                QRView()
            default:
                Text("Detail")
            }
        }
    }
    
    enum Sheet: SheetEnum {
        case accountList
        case preview
        
        var id: String { UUID().uuidString }
        
        @ViewBuilder var body: some View {
            switch self {
            case .accountList:
                MoveMoneySheet()
            case .preview:
                MoveMoneySheet()
            }
        }
    }
    
    @Published var path: [Router] = []
    @Published var currentSheet: Sheet?
    var sheetStack: [Sheet] = []
}
