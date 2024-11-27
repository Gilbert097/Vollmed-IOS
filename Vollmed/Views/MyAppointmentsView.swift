//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    @State private var appointments: [Appointment] = []
    private let viewModel = MyAppointmentsViewModel(service: AppointmentNetworkingService())
    
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
            self.appointments = await viewModel.getAllAppointments()
        }
    }
}

#Preview {
    MyAppointmentsView()
}
