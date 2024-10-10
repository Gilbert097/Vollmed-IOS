//
//  SignInView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 09/10/24.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = .init()
    @State private var password: String = .init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 36, alignment: .center)
            
            Text("Olá!")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            
            Text("Preencha para acessar sua conta.")
                .font(.title3)
                .bold()
                .foregroundStyle(.gray)
                .padding(.bottom)
            
            LabelAndTextFieldView(text: $email,
                                  label: "Email",
                                  placeHolder: "Insira seu email",
                                  type: .emailAddress,
                                  autocapitalization: .never)
            
            LabelAndTextFieldView(text: $password,
                                  label: "Senha",
                                  placeHolder: "Insira sua senha",
                                  isSecureField: true)
            
            Button {
                
            } label: {
                ButtonView(text: "Entrar")
            }
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("Ainda não possui uma conta? Cadastre-se")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .foregroundStyle(.accent)

        }
        .padding()
    }
}

#Preview {
    SignInView()
}
