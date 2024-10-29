//
//  HttpClient.swift
//  Vollmed
//
//  Created by Gilberto Silva on 29/10/24.
//

import Foundation

protocol HttpClient {
    func sendRequest<T: Decodable>(endpoint: Enpoint, response: T.Type) async -> Result<T, RequestError>
}
 
