//
//  SignUpViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 14/11/24.
//

import Foundation

class SignUpViewModel {
    
    private let service: SignUpServiceable
    
    init(service: SignUpServiceable) {
        self.service = service
    }
    
    public func registerPatient(patient: Patient) async -> Bool {
        let result = await service.registerPatient(patient: patient)
        
        switch result {
        case .success(let patientRegistred):
            if patientRegistred != nil {
                print("Paciente cadastrado com sucesso!")
                return true
            } else {
                print("Erro ao cadastrar paciente!!")
                return false
            }
        case .failure(_):
            print("Erro ao cadastrar paciente!!")
            return false
        }
    }
}
