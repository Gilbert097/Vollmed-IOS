//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 07/10/24.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var isAppointmentScheduled = false
    @State private var showAlert = false
    
    private let isRescheduleView: Bool
    private let appointmentID: String?
    
    private let specialistID: String
    private let service = WebService()
    private let authManager = AuthenticationManager.shared
    
    init(specialistID: String, isRescheduleView: Bool = false, appointmentID: String? = nil) {
        self.isRescheduleView = isRescheduleView
        self.appointmentID = appointmentID
        self.specialistID = specialistID
    }
    
    private func rescheduleAppointment() async {
        do {
            guard let appointmentID else { return }
            
            if let _ = try await service.resheduleAppointment(appointmentID: appointmentID, date: selectedDate.convertToString()) {
                print("Consulta reagendada com sucesso!")
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao realizar reagendamento: \(error)")
        }
        showAlert = true
    }
    
    private func scheduleAppointment() async {
        
        do {
            guard let patientID = authManager.patientID else {
                print("ID do paciente não informado!")
                return
            }
            
            let request = ScheduleAppointmentRequest(specialist: specialistID,
                                                     patient: patientID,
                                                     date: selectedDate.convertToString())
            
            if let _ = try await service.sheduleAppointment(appointmentResquest: request) {
                print("Consulta agendada com sucesso!")
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
