//
//  Appointment.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import Foundation

struct Appointment: Codable, Identifiable {
    let id: String
    let date: String
    let specialist: Specialist
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}
