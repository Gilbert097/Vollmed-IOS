//
//  Login.swift
//  Vollmed
//
//  Created by Gilberto Silva on 11/10/24.
//

import Foundation


struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Codable {
    let auth: Bool
    let token: String
    let route: String
    
    enum CodingKeys: String, CodingKey {
        case auth, token
        case route = "rota"
    }
}
