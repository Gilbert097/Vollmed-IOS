//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var specialists: [Specialist] = []
    private var viewModel = HomeViewModel(homeService: HomeNetworkingService(), authenticationService: AuthenticationNetworkingService())
    
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
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await viewModel.logout()
                    }
                } label: {
                    HStack(spacing: 2) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
                }
                
            }
        }
    }
    
    private func loadSpecialists() async  {
        do {
            if let specialists = try await viewModel.getAllSpecialists() {
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
