//
//  AppDependencies.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 2026-06-22.
//

import Foundation

struct AppDependencies {
    let apiClient: ApiClientProtocol
    let downloadManager: DownloadMangerProtocol

    init(
        apiClient: ApiClientProtocol = ApiClient(),
        downloadManager: DownloadMangerProtocol = DownloadManger()
    ) {
        self.apiClient = apiClient
        self.downloadManager = downloadManager
    }
}
