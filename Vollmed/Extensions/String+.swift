//
//  String+.swift
//  Vollmed
//
//  Created by Gilberto Silva on 07/10/24.
//

import Foundation

extension String {
    
    func convertDateStringToReadableDate() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd/MM/yyyy 'às' HH:mm"
            return outputDateFormatter.string(from: date)
        }
        
        return .init()
    }
}
