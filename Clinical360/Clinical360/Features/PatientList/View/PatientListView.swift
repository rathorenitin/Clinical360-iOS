//
//  PatientListView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 13/06/26.
//

import SwiftUI

struct PatientListView: View {
    
    @StateObject var viewModel: PatientListViewModel
    let dependencies: AppDependencies
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                        .task {
                            await viewModel.getPatients()
                        }
                    
                case let .loaded(patientList):
                    List(patientList) { patient in
                        NavigationLink(
                            destination: PatientDetailScene.makeView(patient: patient, dependencies: dependencies)
                        ) {
                            PatientListCell(patient: patient)
                        }
                    }
                    .listStyle(.insetGrouped)
                    .navigationBarTitleDisplayMode(.large)
                    
                case let .empty(message):
                    EmptyStateView(message: message)
                    
                case let .error(message):
                    ErrorView(message: message) {
                        viewModel.state = .loading
                    }
                    
                }
            }
            .frame(alignment: .topLeading)
            .navigationTitle("Patients")
        }
        
    }
}
