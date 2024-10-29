//
//  ScheduleAppointmentViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 29/10/24.
//

import Foundation

struct ScheduleAppointmentViewModel {
    
    private let service = WebService()
    private let authManager = AuthenticationManager.shared
    
    public func scheduleAppointment(specialistID: String, selectedDate: Date) async -> Bool {
        do {
            guard let patientID = authManager.patientID else {
                print("ID do paciente não informado!")
                return false
            }
            
            let request = ScheduleAppointmentRequest(specialist: specialistID,
                                                     patient: patientID,
                                                     date: selectedDate.convertToString())
            
            if let _ = try await service.sheduleAppointment(appointmentResquest: request) {
                print("Consulta agendada com sucesso!")
                return true
            } else {
                return false
            }
        } catch {
            print("Ocorreu um erro ao realizar agendamento: \(error)")
            return false
        }
    }
    
    public func rescheduleAppointment(appointmentID: String?, selectedDate: Date) async -> Bool {
        do {
            guard let appointmentID else { return false}
            
            if let _ = try await service.resheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString()) {
                print("Consulta reagendada com sucesso!")
                return true
            } else {
                return false
            }
        } catch {
            print("Ocorreu um erro ao realizar reagendamento: \(error)")
            return false
        }
    }
}
