//
//  SignInViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 14/11/24.
//

import Foundation

class SignInViewModel {
    
    private let authenticationService: AuthenticationServiceable
    private let authManager = AuthenticationManager.shared
    
    public init(authenticationService: AuthenticationServiceable) {
        self.authenticationService = authenticationService
    }
    
    public func login(email: String, password: String) async throws -> Bool {
        let request = LoginRequest(email: email, password: password)
        let result = await authenticationService.login(request: request)
        
        switch result {
        case .success(let response):
            if let response {
                authManager.saveToken(token: response.token)
                authManager.savePatientID(id: response.id)
                return true
            } else {
                return false
            }
        case .failure(let error):
            print(error.localizedDescription)
            return false
        }
    }
}
