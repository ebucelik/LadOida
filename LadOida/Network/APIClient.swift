//
//  APIClient.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

open class APIClient {

    private let baseUrlString = "https://api.e-control.at/charge/1.0/"

    func startRequest<C: Call>(with call: C) async throws -> C.ResponseType {
        guard var urlComponents = URLComponents(string: baseUrlString + call.path) 
        else { throw APIError.invalidUrlComponents }

        if let parameters = call.parameters {
            urlComponents.queryItems = parameters.compactMap { parameter in
                URLQueryItem(
                    name: parameter.key,
                    value: parameter.value
                )
            }
        }

        guard let url = urlComponents.url else { throw APIError.invalidUrl }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = call.method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(APISecretKey.apiKey, forHTTPHeaderField: "Apikey")
        urlRequest.addValue("https://ladoida.at", forHTTPHeaderField: "Referer")
        urlRequest.httpBody = call.body

        let urlResponse = try await URLSession.shared.data(for: urlRequest)

        guard let httpUrlResponse = urlResponse.1 as? HTTPURLResponse else { throw APIError.responseError }

        if (200...399).contains(httpUrlResponse.statusCode) {
            do {
                return try JSONDecoder().decode(call.parser, from: urlResponse.0)
            } catch {
                throw APIError.decodingError
            }
        }

        if httpUrlResponse.statusCode == 401 {
            throw APIError.unauthorized
        }

        if httpUrlResponse.statusCode == 403 {
            throw APIError.forbidden
        }

        throw APIError.generalError
    }
}
