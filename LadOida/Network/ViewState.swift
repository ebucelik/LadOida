//
//  ViewState.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public enum ViewState<Item: Codable> {
    case none
    case loading
    case loaded(Item)
    case error(Error)
}
