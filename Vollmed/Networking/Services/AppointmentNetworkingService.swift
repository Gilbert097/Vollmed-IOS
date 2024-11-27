//
//  AppointmentNetworkingService.swift
//  Vollmed
//
//  Created by Gilberto Silva on 27/11/24.
//

import Foundation

protocol AppointmentServiceable {
    func getAllAppointments(patientID: String) async -> Result<[Appointment]?, RequestError>
}

struct AppointmentNetworkingService: HttpClient, AppointmentServiceable {
    func getAllAppointments(patientID: String) async -> Result<[Appointment]?, RequestError> {
        await sendRequest(endpoint: AppointmentEndpoint.getAllAppointments(patientID: patientID), responseModel: [Appointment].self)
    }
}
