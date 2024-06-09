//
//  APIError.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public enum APIError: Error {
    case invalidUrl, invalidUrlComponents, decodingError, generalError, unauthorized, forbidden, responseError
}
