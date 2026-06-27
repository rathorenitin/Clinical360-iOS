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
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                switch viewModel.state {
                case .loading:
                    LoadingView()
                        .task {
                            await viewModel.getPatients()
                        }
                    
                case let .loaded(patientList):
                    List(patientList) { patient in
                        Button(action: {
                            coordinator.push(.patientDetail(patient: patient))
                        }) {
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
            .navigationDestination(for: AppRoute.self) { route in
                coordinator.makeDestination(for: route)
            }
        }
        
    }
}
