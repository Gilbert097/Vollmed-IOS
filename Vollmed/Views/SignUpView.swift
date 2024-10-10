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
    @State private var healthPlanSelected: String
    @State private var showAlert = false
    @State private var isPatientRegistred = false
    
    private let service = WebService()
    
    private let healthPlansMock = [
        "Amil", "Unimed", "Bradesco Saúde", "SulAmérica", "Hapvida", "Notredame Intermédica", "São Francisco Saúde", "Golden Cross",
        "Medial Saúde", "América Saúde", "Outro"
    ]
    
    public init() {
        self.healthPlanSelected = healthPlansMock.first!
    }
    
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
                
                LabelAndTextFieldView(text: $name,
                                      label: "Nome",
                                      placeHolder: "Insira seu nome")
                
                LabelAndTextFieldView(text: $email,
                                      label: "Email",
                                      placeHolder: "Insira seu email",
                                      type: .emailAddress,
                                      autocapitalization: .never)
                
                LabelAndTextFieldView(text: $cpf,
                                      label: "CPF",
                                      placeHolder: "Insira seu CPF",
                                      type: .numberPad)
                
                LabelAndTextFieldView(text: $telephone,
                                      label: "Telefone",
                                      placeHolder: "Insira seu telefone",
                                      type: .numberPad)
                
                LabelAndTextFieldView(text: $password,
                                      label: "Senha",
                                      placeHolder: "Insira sua senha",
                                      isSecureField: true)
                
                Text("Selecione o seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                Picker("Plano de súde", selection: $healthPlanSelected) {
                    ForEach(healthPlansMock, id: \.self) { helthPlan in
                        Text(helthPlan)
                    }
                }
                
                Button {
                    Task {
                        await registerPatient()
                    }
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
        .alert(isPatientRegistred ? "Sucesso!" : "Ops, algo deu errado!",
               isPresented: $showAlert,
               presenting: isPatientRegistred) { isRegistred in
            
            Button(action: {
                if isRegistred {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Ok")
            })
        } message: { isRegistred in
            if isRegistred {
                Text("Cadastrado com sucesso!")
            } else {
                Text("Houve um erro ao registrar paciente. Por favor tente novamente ou entre em contato por telefone.")
            }
        }
    }
    
    private func registerPatient() async {
        do {
            let patient = createPatient()
            let patientRegistred = try await service.registerPatient(patient: patient)
            
            if patientRegistred != nil {
                isPatientRegistred = true
                print("Paciente cadastrado com sucesso!")
            } else {
                isPatientRegistred = false
                print("Erro ao cadastrar paciente!!")
            }
        } catch {
            isPatientRegistred = false
            print("Ocorreu um erro ao cadastrar o paciente: \(error)")
        }
        showAlert = true
    }
    
    private func createPatient() -> Patient {
        Patient(
            id: nil,
            cpf: cpf,
            name: name,
            email: email,
            password: password,
            phoneNumber: telephone,
            healthPlan: healthPlanSelected
        )
    }
}

#Preview {
    SignUpView()
}
