//
//  ViewState.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public enum ViewState<Item: Codable & Equatable>: Equatable {
    case none
    case loading
    case loaded(Item)
    case error(Error)

    public static func == (lhs: ViewState<Item>, rhs: ViewState<Item>) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true

        case (.loading, .loading):
            return true

        case let (.loaded(itemLhs), .loaded(itemRhs)):
            return itemLhs == itemRhs

        case (.error, .error):
            return true

        default:
            return false
        }
    }
}
