//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    @State private var reasonToCancel: String = ""
    
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
                print("Consulta cancelada com sucesso!")
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
    CancelAppointmentView()
}
