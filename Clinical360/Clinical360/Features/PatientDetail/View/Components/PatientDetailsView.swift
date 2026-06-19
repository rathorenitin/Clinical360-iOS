//
//  PatientDetailsView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 19/06/26.
//

import SwiftUI

struct PatientDetailsView: View {
    
    var patient: PatientDetail
    
    var body: some View {
        
        List {
            
            Section(header: Text("Patient name")) {
                self.patientName(patient)
            }
            
            Section(header: Text("Location")) {
                Text("Ward: \(patient.ward.name) · \(patient.ward.number) · \(patient.ward.bed)")
                    .font(.body)
            }
            
            Section(header: Text("Care Team")) {
                Text("Treating Doctor: \(patient.treatingDoctor.name) (\(patient.treatingDoctor.specialty))")
                    .font(.body)
            }
            
            Section(header: Text("Clinical")) {
                VStack(alignment: .leading, spacing: 8) {
                    if !patient.conditions.isEmpty {
                        Text("Conditions: \(patient.conditions.joined(separator: ", "))")
                            .font(.body)
                    }
                    if !patient.symptoms.isEmpty {
                        Text("Symptoms: \(patient.symptoms.joined(separator: ", "))")
                            .font(.body)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            if !patient.medications.isEmpty {
                Section(header: Text("Medications")) {
                    ForEach(patient.medications) { medication in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(medication.name)
                                .font(.body)
                            Text("\(medication.dose) · \(medication.frequency)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            
            Section(header: Text("Updated At")) {
                Text("Last updated: \(formatDate(patient.lastUpdatedUtc))")
                    .font(.caption)
            }
        }
        .listStyle(.insetGrouped)
    }
    
    private func patientName(_ patient: PatientDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(patient.fullName)
                .font(.system(size: 24, weight: .semibold))
            
            Text("MRN: \(patient.mrn)")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text("Age: \(patient.age), Sex: \(patient.sex)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}
