//
//  Enpoint.swift
//  Vollmed
//
//  Created by Gilberto Silva on 29/10/24.
//

import Foundation

protocol Enpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String] { get }
    var body: [String: String]? { get }
}

extension Enpoint {
    var scheme: String { "http" }
    var host: String { "localhost" }
}
