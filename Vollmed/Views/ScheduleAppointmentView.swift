//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 07/10/24.
//

import SwiftUI

let patientID = "46b84859-8d2c-4dda-bde7-a2018c5f55d7"

struct ScheduleAppointmentView: View {
    
    @State private var selectedDate = Date()
    let specialistID: String
    private let service = WebService()
    
    private func scheduleAppointment() async {
        
        do {
            let request = ScheduleAppointmentRequest(specialist: specialistID,
                                                     patient: patientID,
                                                     date: selectedDate.convertToString())
            
            if let response = try await service.sheduleAppointment(appointmentResquest: request) {
                print("Consulta agendada com sucesso!")
                print(response)
            }
        } catch {
            print("Ocorreu um erro ao realizar agendamento: \(error)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button {
                Task {
                    await scheduleAppointment()
                }
            } label: {
                ButtonView(text: "Agendar consulta")
            }
        }
        .padding()
        .navigationTitle("Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: .init())
}
