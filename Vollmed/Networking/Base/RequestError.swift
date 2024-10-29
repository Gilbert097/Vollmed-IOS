//
//  RequestError.swift
//  Vollmed
//
//  Created by Gilberto Silva on 29/10/24.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case cutom(_ error: [String: Any])
    
    var customMessage: String {
        switch self {
        case .decode:
            return "erro de decodificação"
        case .unauthorized:
            return "sessão expirada"
        default:
            return "erro desconhecido"
        }
    }
}
