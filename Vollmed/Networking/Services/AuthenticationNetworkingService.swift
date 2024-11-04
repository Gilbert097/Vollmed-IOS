//
//  AuthenticationNetwoekingService.swift
//  Vollmed
//
//  Created by Gilberto Silva on 04/11/24.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
}

struct AuthenticationNetworkingService: HttpClient, AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError> {
        await sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
}
