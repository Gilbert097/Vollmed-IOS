//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var specialists: [Specialist] = []
    private let service = WebService()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(self.specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear{
            Task {
                await loadSpecialists()
            }
        }
    }
    
    private func loadSpecialists() async  {
        do {
            if let specialists = try await service.getAllSpecialists() {
                self.specialists = specialists
            }
        } catch {
            print("Ocorreu um erro ao obter os especialistas. \(error.localizedDescription)")
        }
    }
}

#Preview {
    HomeView()
}
