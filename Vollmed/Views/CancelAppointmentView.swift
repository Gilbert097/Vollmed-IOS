//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var reasonToCancel: String = ""
    @State private var showAlert = false
    @State private var isAppointmentCanceled = false
    
    let appointmentID: String
    private let service = WebService()
    
    private func cancelAppointment() async {
        
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                isAppointmentCanceled = true
                print("Consulta cancelada com sucesso!")
            } else {
                isAppointmentCanceled = false
            }
        } catch {
            isAppointmentCanceled = false
            print("Ocorreu um erro ao efetuar o cancelamento da consulta: \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(.lightBlue.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(height: 300)
            
            Button {
                Task{
                    await cancelAppointment()
                }
            } label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            }
        }
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .alert(isAppointmentCanceled ? "Sucesso!" : "Ops, algo deu errado!",
               isPresented: $showAlert,
               presenting: isAppointmentCanceled) { isCanceled in
            Button(action: {
                if isCanceled {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Ok")
            })
        } message: { isCanceled in
            if isCanceled {
                Text("A consulta foi cancelada com sucesso!")
            } else {
                Text("Houve um erro ao cancelar sua consulta. Por favor tente novamente ou entre em contato por telefone.")
            }
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentID: .init())
}
