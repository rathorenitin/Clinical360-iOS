//
//  PatientReport.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import Foundation

// MARK: - PatientReport
struct PatientReport: Decodable, Identifiable {
    let id: Int
    let fullName: String
    let reports: [Report]
}

// MARK: - Report
struct Report: Decodable {
    let reportId, type: String
    let dateUtc: Date
    let url: String
}
