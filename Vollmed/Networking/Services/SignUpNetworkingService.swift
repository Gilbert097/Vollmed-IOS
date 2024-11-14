//
//  SignUpNetworkingService.swift
//  Vollmed
//
//  Created by Gilberto Silva on 14/11/24.
//

import Foundation

protocol SignUpServiceable {
    func registerPatient(patient: Patient) async -> Result<Patient?, RequestError>
}

struct SignUpNetworkingService: HttpClient, SignUpServiceable {
    
    func registerPatient(patient: Patient) async -> Result<Patient?, RequestError> {
        return await sendRequest(endpoint: SignUpEndpoint.registerPatient(patient: patient), responseModel: Patient.self)
    }
}
