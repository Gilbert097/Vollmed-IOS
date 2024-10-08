//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 07/10/24.
//

import SwiftUI

let patientID = "46b84859-8d2c-4dda-bde7-a2018c5f55d7"

struct ScheduleAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var isAppointmentScheduled = false
    @State private var showAlert = false
    
    private let isRescheduleView: Bool
    private let appointmentID: String?
    
    private let specialistID: String
    private let service = WebService()
    
    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
        self.specialistID = specialistID
    }
    
    private func rescheduleAppointment() async {
        print("Consulta reagendada com sucesso!")
    }
    
    private func scheduleAppointment() async {
        
        do {
            let request = ScheduleAppointmentRequest(specialist: specialistID,
                                                     patient: patientID,
                                                     date: selectedDate.convertToString())
            
            if let response = try await service.sheduleAppointment(appointmentResquest: request) {
                print("Consulta agendada com sucesso!")
                print(response)
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao realizar agendamento: \(error)")
        }
        showAlert = true
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
                    if isRescheduleView {
                        await rescheduleAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                }
            } label: {
                ButtonView(text: isRescheduleView ? "Reagendar consulta" :"Agendar consulta")
            }
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagendar consulta" :"Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert( isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: isAppointmentScheduled) { isScheduled in
            Button(action: {
                if isScheduled {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Ok")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi \(isRescheduleView ? "reagendada": "agendada") com sucesso!")
            } else {
                Text("Houve um erro ao \(isRescheduleView ? "reagendar": "agendar") sua consulta. Por favor tente novamente ou entre em contato por telefone.")
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistID: .init())
}
