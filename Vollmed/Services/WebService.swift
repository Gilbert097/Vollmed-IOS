//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
    func downloadImage(from urlImage: String) async throws -> UIImage? {
        
        guard let url = URL(string: urlImage) else {
            print("Erro na requisição.")
            return nil
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
       
        return UIImage(data: data)
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let path = baseURL + "/especialista"
        
        guard let url = URL(string: path) else {
            print("Erro na requisição.")
            return nil
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
}
