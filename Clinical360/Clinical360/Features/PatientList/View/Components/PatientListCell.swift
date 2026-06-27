//
//  PatientListCell.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 17/06/26.
//

import SwiftUI

struct PatientListCell: View {

    var patient: PatientRecord
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(patient.fullName)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text("\(patient.wardNumber) · \(patient.bed)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(patient.doctorName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 8)
        }
    }
}
