//
//  PatientDetailView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 18/06/26.
//

import SwiftUI

struct PatientDetailView: View {
    
    @StateObject var viewModel: PatientDetailViewModel
    let dependencies: AppDependencies
    @ObservedObject var coordinator: AppCoordinator
    @State private var showPreview: Bool = false
    
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
            Button(action: {
                coordinator.push(.patientReports(patient: viewModel.patient))
            }) {
                Text("View Reports")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(12)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .background(Color(.systemBackground))
        }
    }
}
