//
//  MyAppointmentCardView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 08/10/24.
//

import SwiftUI

struct MyAppointmentCardView: View {
    
    @State private var specialistImage: UIImage? = nil
    
    private let service = WebService()
    var appointment: Appointment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                if let specialistImage {
                    Image(uiImage: specialistImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(appointment.specialist.name)
                        .font(.title3)
                        .bold()
                    Text(appointment.specialist.specialty)
                    Text(appointment.date.convertDateStringToReadableDate())
                }
            }
            
            HStack {
                NavigationLink {
                    ScheduleAppointmentView(specialistID: appointment.specialist.id, 
                                            isRescheduleView: true,
                                            appointmentID: appointment.id)
                } label: {
                    ButtonView(text: "Remarcar")
                }
                
                Button {
                    
                } label: {
                    ButtonView(text: "Cancelar", buttonType: .cancel)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.lightBlue).opacity(0.15))
        .cornerRadius(16.0)
        .onAppear {
            Task {
                await loadSpecialistImage()
            }
        }
    }
    
    private func loadSpecialistImage() async {
        do {
            self.specialistImage = try await service.downloadImage(from: appointment.specialist.imageUrl)
        } catch {
            print("Ocorreu um erro ao carregar a image: \(error.localizedDescription)")
        }
    }
}

#Preview {
    let specialist = Specialist(id: "c84k5kf",
                                name: "Dr. Carlos Alberto",
                                crm: "123456",
                                imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                                specialty: "Neurologia",
                                email: "carlos.alberto@example.com",
                                phoneNumber: "(11) 99999-9999")
    
    return MyAppointmentCardView(
        appointment: .init(id: "123",
                           date: Date().convertToString(),
                           specialist: specialist))
}
