//
//  LabelAndTextFieldView.swift
//  Vollmed
//
//  Created by Gilberto Silva on 10/10/24.
//

import SwiftUI

struct LabelAndTextFieldView: View {
    
    @Binding var text: String
    
    let label: String
    let placeHolder: String
    let type: UIKeyboardType
    let autocapitalization: TextInputAutocapitalization?
    let isSecureField: Bool
    
    public init(text: Binding<String>,
                label: String,
                placeHolder: String,
                type: UIKeyboardType = .default,
                autocapitalization: TextInputAutocapitalization? = nil,
                isSecureField: Bool = false) {
        self._text = text
        self.label = label
        self.placeHolder = placeHolder
        self.type = type
        self.autocapitalization = autocapitalization
        self.isSecureField = isSecureField
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text(label)
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            if isSecureField {
                SecureField(placeHolder, text: $text)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            } else {
                TextField(placeHolder, text: $text)
                    .padding(14)
                    .background(.gray.opacity(0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .keyboardType(type)
                    .textInputAutocapitalization(autocapitalization)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LabelAndTextFieldView(text: .constant("Text"), label: "Label", placeHolder: "PlaceHolder")
}
