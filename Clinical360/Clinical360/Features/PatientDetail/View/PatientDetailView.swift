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
}
