//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 21/10/24.
//

import Foundation

struct HomeViewModel {
    
    private let service: HomeServiceable
    private let authManager = AuthenticationManager.shared
    
    public init(service: HomeServiceable) {
        self.service = service
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let specialists = try await service.getAllSpecialists()
        
        switch specialists {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
      
    }
    
    func logout() async {
        do {
            let oldService = WebService()
            let isSuccess = try await oldService.logout()
            
            if isSuccess {
                authManager.removeToken()
                authManager.removePaitentID()
            }
            
        } catch {
            print("Ocorreu um erro ao tentar realizar logout: \(error)")
        }
    }
}
