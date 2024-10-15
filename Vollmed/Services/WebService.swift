//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    private let imageCache = NSCache<NSString, UIImage>()
    
    func logout() async throws -> Bool {
        let endpoint = baseURL + "/auth/logout"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return false
        }
        
        guard let token = KeychainHelper.get(for: "app-vollmed-token") else {
            print("Token não informado!")
            return false
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        }
        
        return false
    }
    
    func login(request: LoginRequest) async throws -> LoginResponse? {
        let endpoint = baseURL + "/auth/login"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return nil
        }
        
        let jsonData = try JSONEncoder().encode(request)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        return loginResponse
    }
    
    func registerPatient(patient: Patient) async throws -> Patient? {
        let endpoint = baseURL + "/paciente"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return nil
        }
        
        let jsonData = try JSONEncoder().encode(patient)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let patientResponse = try JSONDecoder().decode(Patient.self, from: data)
        
        return patientResponse
    }
    
    
    func cancelAppointment(appointmentID: String, reasonToCancel: String) async throws -> Bool {
        let endpoint = "\(baseURL)/consulta/\(appointmentID)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return false
        }
        
        guard let token = KeychainHelper.get(for: "app-vollmed-token")  else {
            print("Token não informado!")
            return false
        }
        
        let requestData: [String: String] = ["motivo_cancelamento": reasonToCancel]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            return true
        }
        
        return false
    }
    
    func resheduleAppointment(appointmentID: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint =  "\(baseURL)/consulta/\(appointmentID)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return nil
        }
        
        guard let token = KeychainHelper.get(for: "app-vollmed-token")  else {
            print("Token não informado!")
            return nil
        }
        
        let requestData: [String: String] = ["data": date]
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    func getAllAppointments() async throws -> [Appointment]? {
        
        guard let patientID = KeychainHelper.get(for: "app-vollmed-patient-id") else {
            print("ID do paciente não informado!")
            return nil
        }
        
        let endpoint =  "\(baseURL)/paciente/\(patientID)/consultas"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return nil
        }
        
        guard let token = KeychainHelper.get(for: "app-vollmed-token")  else {
            print("Token não informado!")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "Get"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointments = try JSONDecoder().decode([Appointment].self, from: data)
        
        return appointments
    }
    
    func sheduleAppointment(appointmentResquest: ScheduleAppointmentRequest) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consulta"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na requisição.")
            return nil
        }
        
        guard let token = KeychainHelper.get(for: "app-vollmed-token")  else {
            print("Token não informado!")
            return nil
        }
        
        let jsonData = try JSONEncoder().encode(appointmentResquest)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        
        guard let url = URL(string: imageURL) else {
            print("Erro na requisição.")
            return nil
        }
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        self.imageCache.setObject(image, forKey: imageURL as NSString)
        
        return image
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let path = baseURL + "/especialista"
        
        guard let url = URL(string: path) else {
            print("Erro na requisição.")
            return nil
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
}
