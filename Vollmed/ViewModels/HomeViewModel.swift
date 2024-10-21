//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Gilberto Silva on 21/10/24.
//

import Foundation

struct HomeViewModel {
    
    let service = WebService()
    
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
}
