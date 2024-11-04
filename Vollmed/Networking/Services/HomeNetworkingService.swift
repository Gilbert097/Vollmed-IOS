//
//  HomeNetworkingService.swift
//  Vollmed
//
//  Created by Gilberto Silva on 04/11/24.
//

import Foundation

protocol HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}


struct HomeNetworkingService: HttpClient, HomeServiceable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        await sendRequest(endpoint: HomeEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }
}
