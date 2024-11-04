//
//  AutenticationEndpoint.swift
//  Vollmed
//
//  Created by Gilberto Silva on 04/11/24.
//

import Foundation

enum AuthenticationEndpoint {
    case logout
}

extension AuthenticationEndpoint: Enpoint {
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .logout:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .logout:
            guard  let token = AuthenticationManager.shared.token else { return nil }
            
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .logout:
            return nil
        }
    }
}
