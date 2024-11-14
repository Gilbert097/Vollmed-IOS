//
//  AuthenticationNetwoekingService.swift
//  Vollmed
//
//  Created by Gilberto Silva on 04/11/24.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
    func login(request: LoginRequest) async -> Result<LoginResponse?, RequestError>
}

struct AuthenticationNetworkingService: HttpClient, AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError> {
        await sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
    
    func login(request: LoginRequest) async -> Result<LoginResponse?, RequestError> {
        return await sendRequest(endpoint: AuthenticationEndpoint.login(request: request), responseModel: LoginResponse.self)
    }
}
