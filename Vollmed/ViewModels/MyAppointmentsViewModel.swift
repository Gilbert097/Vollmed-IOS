//
//  MyAppointmentsViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 27/11/24.
//

import Foundation

struct MyAppointmentsViewModel {
    
    private let service: AppointmentServiceable
    private let authManager = AuthenticationManager.shared
    
    init(service: AppointmentServiceable) {
        self.service = service
    }
    
    public func getAllAppointments() async -> [Appointment] {
        
        guard let patientID = authManager.patientID else {
            print("ID do paciente não informado!")
            return []
        }
        
        let result = await service.getAllAppointments(patientID: patientID)
        
        switch result {
        case .success(let appointments):
            return appointments ?? []
        case .failure(let error):
            print("Ocorreu um erro ao recuperar lista de consultas: \(error)")
            return []
        }
    }
}
