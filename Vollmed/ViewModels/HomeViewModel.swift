//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 21/10/24.
//

import Foundation

struct HomeViewModel {
    
    private let service = WebService()
    private let authManager = AuthenticationManager.shared
    
    func getAllSpecialists() async throws -> [Specialist]? {
        
        do {
            if let specialists = try await service.getAllSpecialists() {
                return specialists
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas. \(error)")
            throw error
        }
        
        return nil
    }
    
    func logout() async {
        do {
            let isSuccess = try await service.logout()
            
            if isSuccess {
                authManager.removeToken()
                authManager.removePaitentID()
            }
            
        } catch {
            print("Ocorreu um erro ao tentar realizar logout: \(error)")
        }
    }
}
