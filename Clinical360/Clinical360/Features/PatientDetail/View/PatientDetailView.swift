//
//  PatientDetailView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 18/06/26.
//

import SwiftUI

struct PatientDetailView: View {
    
    @StateObject var viewModel: PatientDetailViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
                    .task {
                        await viewModel.getPatientDetail()
                    }
                
            case let .loaded(patientDetail):

                PatientDetailsView(patient: patientDetail)
                
                reportView()
                
            case let .empty(message):
                EmptyStateView(message: message)
                
            case let .error(message):
                ErrorView(message: message) {
                    viewModel.state = .loading
                }
                
            }
        }
        .frame(alignment: .topLeading)
        .navigationTitle(viewModel.patient.fullName)
    }
    
    private func reportView() -> some View {
        VStack {
            VStack(spacing: 12) {
                Button(action: {
                    Task {

                    }
                }) {
                    Text("Download Report")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
}
