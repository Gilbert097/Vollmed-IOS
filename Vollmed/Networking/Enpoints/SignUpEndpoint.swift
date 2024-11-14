//
//  SignUpEndpoint.swift
//  Vollmed
//
//  Created by Gilberto Silva on 14/11/24.
//

import Foundation

enum SignUpEndpoint {
    case registerPatient(patient: Patient)
}

extension SignUpEndpoint: Enpoint {
    
    var path: String {
        switch self {
        case .registerPatient:
            return "/paciente"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .registerPatient:
            return .post
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .registerPatient:
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .registerPatient(let patient):
            return ["cpf": patient.cpf,
                    "nome": patient.name,
                    "email": patient.email,
                    "senha": patient.password,
                    "telefone": patient.phoneNumber,
                    "planoSaude": patient.healthPlan]
        }
    }
    
}
