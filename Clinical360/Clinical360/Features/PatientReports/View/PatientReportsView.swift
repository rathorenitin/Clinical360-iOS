//
//  PatientReportsView.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import SwiftUI

struct PatientReportsView: View {
    @StateObject var viewModel: PatientReportsViewModel
    @State private var showPreview: Bool = false
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                LoadingView()
                    .task {
                        await viewModel.getPatientReports()
                    }
                
            case let .loaded(reports):
                List(reports, id: \.reportId) { report in
                    PatientReportsCell(
                        report: report,
                        isSaved: viewModel.isReportSaved(report),
                        isDownloading: viewModel.isDownloading(report),
                        onDownload: {
                            Task {
                                await viewModel.downloadReport(report)
                                if let _ = viewModel.currentReportURL {
                                    showPreview = true
                                }
                            }
                        },
                        onView: {
                            let url = viewModel.localFileURL(for: report)
                            viewModel.currentReportURL = url
                            showPreview = true
                        }
                    )
                }
                .listStyle(.insetGrouped)
                
            case let .empty(message):
                EmptyStateView(message: message)
                
            case let .error(message):
                ErrorView(message: message) {
                    viewModel.state = .loading
                }
            }
        }
        .navigationTitle("Reports")
        .sheet(isPresented: $showPreview) {
            if let url = viewModel.currentReportURL {
                QuickLookPreview(url: url)
            }
        }
    }
}
