//
//  PatientReportsScene.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 2026-06-22.
//

import SwiftUI

struct PatientReportsScene {
    static func makeView(for patient: PatientRecord, dependencies: AppDependencies, coordinator: AppCoordinator) -> some View {
        let repository = PatientReportsRepository(apiClient: dependencies.apiClient,
                              downloadManger: dependencies.downloadManager)
        let useCase = PatientReportsUseCase(repository: repository)
        let viewModel = PatientReportsViewModel(patient: patient, useCase: useCase)
        return PatientReportsView(viewModel: viewModel)
    }
}
