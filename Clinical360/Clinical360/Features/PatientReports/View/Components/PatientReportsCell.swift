//
//  PatientReportsCell.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import SwiftUI

struct PatientReportsCell: View {
    let report: Report
    let isSaved: Bool
    let isDownloading: Bool
    let onDownload: () -> Void
    let onView: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(report.type)
                    .font(.headline)
                Text(report.reportId)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if isSaved {
                Button("View") {
                    onView()
                }
                .buttonStyle(.borderedProminent)
            } else {
                Button(action: {
                    onDownload()
                }) {
                    if isDownloading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 24, height: 24)
                    } else {
                        Text("Download")
                    }
                }
                .buttonStyle(.bordered)
                .disabled(isDownloading)
            }
        }
        .padding(.vertical, 8)
    }
}
