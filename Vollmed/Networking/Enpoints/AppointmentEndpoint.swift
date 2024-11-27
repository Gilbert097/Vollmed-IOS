//
//  AppointmentEndpoint.swift
//  Vollmed
//
//  Created by Gilberto Silva on 27/11/24.
//

import Foundation

enum AppointmentEndpoint {
    case getAllAppointments(patientID: String)
}

extension AppointmentEndpoint: Enpoint {
    var path: String {
        switch self {
        case .getAllAppointments(let patientID):
            return "/paciente/\(patientID)/consultas"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllAppointments:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getAllAppointments:
            guard  let token = AuthenticationManager.shared.token else { return nil }
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getAllAppointments:
            return nil
        }
    }
}
