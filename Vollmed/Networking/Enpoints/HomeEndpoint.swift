//
//  HomeEndpoint.swift
//  Vollmed
//
//  Created by Gilberto Silva on 29/10/24.
//

import Foundation

enum HomeEndpoint {
    case getAllSpecialists
}

extension HomeEndpoint: Enpoint {
    var path: String {
        switch self {
        case .getAllSpecialists:
            return "/especialista"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllSpecialists:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
}
