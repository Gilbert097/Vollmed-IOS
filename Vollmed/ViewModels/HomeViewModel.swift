//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 21/10/24.
//

import Foundation

struct HomeViewModel {
    
    private let homeService: HomeServiceable
    private let authenticationService: AuthenticationServiceable
    private let authManager = AuthenticationManager.shared
    
    public init(homeService: HomeServiceable, authenticationService: AuthenticationServiceable) {
        self.homeService = homeService
        self.authenticationService = authenticationService
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let result = try await homeService.getAllSpecialists()
        
        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
      
    }
    
    func logout() async {
        let result = await authenticationService.logout()
        
        switch result {
        case .success(_):
            authManager.removeToken()
            authManager.removePaitentID()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
