//
//  DownloadManger.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 21/06/26.
//

import Foundation

protocol DownloadMangerProtocol: AnyObject {
    
    func saveReport(tempURL: URL, rootDirectory: String, path: String, fileName: String) throws -> URL
    func fileExists(rootDirectory: String, path: String, fileName: String) -> Bool
    func localFileURL(rootDirectory: String, path: String, fileName: String) -> URL
}

class DownloadManger: DownloadMangerProtocol {
    
    private let fileManager = FileManager.default
    
    func saveReport(tempURL: URL, rootDirectory: String, path: String, fileName: String) throws -> URL {
        
        let documentsDir = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        
        let patientDir = documentsDir.appendingPathComponent(String(rootDirectory),isDirectory: true)
        
        let typeDir = patientDir.appendingPathComponent(path, isDirectory: true)
        try fileManager.createDirectory(at: typeDir, withIntermediateDirectories: true)
        
        let fileName = fileName + ".pdf"
        let destinationURL = typeDir.appendingPathComponent(fileName, isDirectory: false)
        
        if fileManager.fileExists(atPath: destinationURL.path) {
            try fileManager.removeItem(at: destinationURL)
        }
        
        // MOVE
        try fileManager.moveItem(at: tempURL, to: destinationURL)
        
        return destinationURL
    }

    func fileExists(rootDirectory: String, path: String, fileName: String) -> Bool {
        let documentsDir = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        let patientDir = documentsDir.appendingPathComponent(String(rootDirectory),isDirectory: true)
        let typeDir = patientDir.appendingPathComponent(path, isDirectory: true)
        let fileName = fileName + ".pdf"
        let destinationURL = typeDir.appendingPathComponent(fileName, isDirectory: false)
        return fileManager.fileExists(atPath: destinationURL.path)
    }

    func localFileURL(rootDirectory: String, path: String, fileName: String) -> URL {
        let documentsDir = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        let patientDir = documentsDir.appendingPathComponent(String(rootDirectory),isDirectory: true)
        let typeDir = patientDir.appendingPathComponent(path, isDirectory: true)
        let fileName = fileName + ".pdf"
        let destinationURL = typeDir.appendingPathComponent(fileName, isDirectory: false)
        return destinationURL
    }
}
