//
//  SignUpView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 09/10/24.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
                    .padding(.vertical)
                
                Text("Olá")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Insira seus dados para cirar uma conta.")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                    
            }
        }
        .scrollIndicators(.never)
        .navigationBarBackButtonHidden()
        .padding()
    }
}

#Preview {
    SignUpView()
}
