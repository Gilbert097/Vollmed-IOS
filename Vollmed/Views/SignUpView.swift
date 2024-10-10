//
//  SignUpView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 09/10/24.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = .init()
    @State private var email: String = .init()
    @State private var cpf: String = .init()
    @State private var telephone: String = .init()
    @State private var password: String = .init()
    
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
                
                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu nome", text: $name)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu email", text: $email)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu CPF", text: $cpf)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(.numberPad)
                
                Text("Telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu telefone", text: $telephone)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(.numberPad)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                SecureField("Insira sua senha", text: $password)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                Button {
                    
                } label: {
                    ButtonView(text: "Cadastrar")
                }
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Já possui uma conta? faça o login!")
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
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
