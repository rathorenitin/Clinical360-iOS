//
//  PatientDetailScene.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 2026-06-22.
//

import SwiftUI

struct PatientDetailScene {
    static func makeView(patient: PatientRecord, dependencies: AppDependencies) -> some View {
        let repository = PatientDetailRepository(apiClient: dependencies.apiClient)
        let useCase = PatientDetailUseCase(repository: repository)
        let viewModel = PatientDetailViewModel(patient: patient, useCase: useCase)
        return PatientDetailView(viewModel: viewModel, dependencies: dependencies)
    }
}
