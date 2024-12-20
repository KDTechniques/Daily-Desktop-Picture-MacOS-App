//
//  FileStorageManager.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import Foundation

enum ImageURLsFileTypes {
    case preSavedURLs
    case queryURLs
    
    func fileName(_ queryText: String) -> String {
        switch self {
        case .preSavedURLs:
            "UnsplashPreSavedImageURLs/\(queryText).json"
        case .queryURLs:
            "UnsplashQueryURLs/\(queryText).json"
        }
    }
}

actor FileStorageManager {
    // MARK: FUNCTIONS
    
    // MARK: - Get File URL
    private func getFileURL(_ urlFileType: ImageURLsFileTypes, _ queryText: String) async -> URL? {
        let fileManager = FileManager.default
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(urlFileType.fileName(queryText))
    }
    
    // MARK: - Write Data
    func saveURLs(_ urlFileType: ImageURLsFileTypes, _ queryText: String, _ urls: Set<String>) async throws {
        guard let fileURL = await getFileURL(urlFileType, queryText) else {
            throw NSError(domain: "FileStorage", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to get file URL"])
        }
        let jsonData = try JSONSerialization.data(withJSONObject: Array(urls), options: .prettyPrinted)
        try jsonData.write(to: fileURL)
    }
    
    // MARK: - Read Data
    func loadURLs(_ urlFileType: ImageURLsFileTypes, _ queryText: String) async throws -> Set<String> {
        guard let fileURL = await getFileURL(urlFileType, queryText),
              FileManager.default.fileExists(atPath: fileURL.path) else {
            return [] // Return an empty Set if the file doesn't exist
        }
        let jsonData = try Data(contentsOf: fileURL)
        if let urls = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String] {
            return Set(urls)
        } else {
            throw NSError(domain: "FileStorage", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"])
        }
    }
}
