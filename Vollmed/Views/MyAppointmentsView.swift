//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    @State private var appointments: [Appointment] = []
    private let service = WebService()
    
    var body: some View {
        VStack {
            if appointments.isEmpty {
                Text("Não há nenhuma consulta agendada no momento!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundStyle(.cancel)
            } else {
                ScrollView {
                    ForEach(appointments) { appointment in
                        MyAppointmentCardView(appointment: appointment)
                    }
                }
                .scrollIndicators(.never)
            }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .task {
            await loadAllAppointments()
        }
    }
    
    private func loadAllAppointments() async {
        do {
            if let appointments = try await service.getAllAppointments() {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao recuperar lista de consultas: \(error)")
        }
    }
}

#Preview {
    MyAppointmentsView()
}
