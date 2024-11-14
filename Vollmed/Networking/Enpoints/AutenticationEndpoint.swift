//
//  AutenticationEndpoint.swift
//  Vollmed
//
//  Created by Gilberto Silva on 04/11/24.
//

import Foundation

enum AuthenticationEndpoint {
    case logout
    case login(request: LoginRequest)
}

extension AuthenticationEndpoint: Enpoint {
    
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        case .login:
            return "/auth/login"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .logout:
            return .post
        case .login:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .logout:
            guard  let token = AuthenticationManager.shared.token else { return nil }
            return ["Authorization": "Bearer \(token)"]
        case .login:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .logout:
            return nil
        case .login(let resquest):
            return ["email": resquest.email, "senha": resquest.password]
        }
    }
}
