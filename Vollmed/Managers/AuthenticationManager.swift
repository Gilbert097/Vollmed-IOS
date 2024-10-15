//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Gilberto Silva on 15/10/24.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientID: String?
    
    private let tokenKey = "app-vollmed-token"
    private let patientIDKey = "app-vollmed-patient-id"
    
    private init() {
        self.token = KeychainHelper.get(for: self.tokenKey)
        self.patientID = KeychainHelper.get(for: self.patientIDKey)
    }
    
    func saveToken(token: String) {
        runOnMainThread {
            KeychainHelper.save(value: token, key: self.tokenKey)
            self.token = token
        }
    }
    
    func removeToken() {
        runOnMainThread {
            KeychainHelper.remove(for: self.tokenKey)
            self.token = nil
        }
    }
    
    func savePatientID(id: String) {
        runOnMainThread {
            KeychainHelper.save(value: id, key: self.patientIDKey)
            self.patientID = id
        }
    }
    
    func removePaitentID() {
        runOnMainThread {
            KeychainHelper.remove(for: self.patientIDKey)
            self.patientID = nil
        }
    }
    
    private func runOnMainThread(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async(execute: completion)
    }
}
