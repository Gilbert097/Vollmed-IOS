//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Gilberto Silva on 15/10/24.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    @Published var token: String?
    @Published var patientID: String?
    
    private let tokenKey = "app-vollmed-token"
    private let patientIDKey = "app-vollmed-patient-id"
    
    init() {
        self.token = KeychainHelper.get(for: self.tokenKey)
        self.patientID = KeychainHelper.get(for: self.patientIDKey)
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: self.tokenKey)
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(for: self.tokenKey)
        self.token = nil
    }
    
    func savePatientID(id: String) {
        KeychainHelper.save(value: id, key: self.patientIDKey)
        self.patientID = id
    }
    
    func removePaitentID() {
        KeychainHelper.remove(for: self.patientIDKey)
        self.patientID = nil
    }
}
