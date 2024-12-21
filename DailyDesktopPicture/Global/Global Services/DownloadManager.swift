//
//  DownloadManager.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import Foundation

actor DownloadManager {
    var fileName: String = "image\(UUID().uuidString)"
    
    // MARK: - downloadImage
    // Download the image asynchronously
    func downloadImage(_ url: URL) async throws -> URL {
        let imageFileURL: URL = try await getDocumentDirectoryImageURL()
        let (tempURL, _) = try await URLSession.shared.download(from: url)
        
        print("downloadable Image URL: \(url)\n")
        print("tempURL: \(tempURL)\n")
        print("Document directory image file url path: \(imageFileURL)\n")
        
        // Check if a file already exists at the destination, and remove it if needed
        if FileManager.default.fileExists(atPath: imageFileURL.path()) {
            try FileManager.default.removeItem(at: imageFileURL)
        }
        
        try FileManager.default.moveItem(at: tempURL, to: imageFileURL)
        return imageFileURL
    }
    
    // MARK: - Get Document Directory URL
    private func getDocumentDirectoryImageURL() async throws -> URL {
        let folderURL = try await createDocumentsDirectoryIfNeeded()
        await removeAllFiles(folderURL)
        
        // Generate a unique file name using UUID
        let uniqueFileName = UUID().uuidString
        
        // Append the unique file name to the folder URL
        let fullPath = folderURL.appendingPathComponent(uniqueFileName)
        return fullPath
    }
    
    private func createDocumentsDirectoryIfNeeded() async throws -> URL {
        let fileManager = FileManager.default
        let folderName: String = "DailyDesktopPictures"
        guard let documentDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("couldn't able to get documents directory!")
            throw URLError(.fileDoesNotExist)
        }
        let folderURL = documentDirectory.appendingPathComponent(folderName)
        
        // Check if the Documents directory exists
        if !fileManager.fileExists(atPath: folderURL.path) {
            do {
                // Recreate the Documents directory
                try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true)
                print("Documents directory recreated successfully at: \(folderURL.path)")
            } catch {
                print("Failed to recreate Documents directory: \(error)")
            }
        }
        
        return folderURL
    }
    
    private func removeAllFiles(_ folderURL: URL) async {
        let fileManager = FileManager.default
        
        // Ensure the folder exists
        guard fileManager.fileExists(atPath: folderURL.path) else {
            print("Folder does not exist at: \(folderURL.path)")
            return
        }
        
        do {
            // Get the contents of the folder
            let fileURLs = try fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil)
            
            // Iterate over each file and remove it
            for fileURL in fileURLs {
                do {
                    try fileManager.removeItem(at: fileURL)
                    print("Deleted file: \(fileURL.path)")
                } catch {
                    print("Failed to delete file \(fileURL.path): \(error)")
                }
            }
        } catch {
            print("Failed to list contents of folder: \(error)")
        }
    }
}
