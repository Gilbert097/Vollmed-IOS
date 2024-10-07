//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    private let imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        
        guard let url = URL(string: imageURL) else {
            print("Erro na requisição.")
            return nil
        }
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        guard let image = UIImage(data: data) else {
            return nil
        }
        
        self.imageCache.setObject(image, forKey: imageURL as NSString)
        
        return image
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
