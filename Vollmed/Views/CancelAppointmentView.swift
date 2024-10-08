//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    @State private var reasonToCancel: String = ""
    let appointmentID: String
    private let service = WebService()
    
    private func cancelAppointment() async {
        
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso!")
            }
        } catch {
            print("Ocorreu um erro ao efetuar o cancelamento da consulta: \(error)")
        }
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
    }
}

#Preview {
    CancelAppointmentView(appointmentID: .init())
}
