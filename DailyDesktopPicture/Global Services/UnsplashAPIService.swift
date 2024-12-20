//
//  UnsplashAPIService.swift
//  DailyDesktopPicture
//
//  Created by Kavinda Dilshan on 2024-12-18.
//

import SwiftUI

// MARK: MODELS

// MARK: - Unsplash Photo Model
struct UnsplashPhotoModel: Decodable {
    let photo: URLStringModel
    
    enum CodingKeys: String, CodingKey {
        case photo = "urls"
    }
}

// MARK: - URL String Model
struct URLStringModel: Decodable {
    let urlString: String
    
    enum CodingKeys: String, CodingKey {
        case urlString = "thumb" // change to `raw` later
    }
}

// MARK: - Search Photo Model
struct SearchPhotoModel: Decodable {
    let results: [UnsplashPhotoModel]
}

// MARK: Unsplash API Service Actor
actor UnsplashAPIService {
    // MARK: - PROPERTIES
    private let fileStorageManager: FileStorageManager = .init()
    private let accessKey = ""
    private let randomPhotoURLString = "https://api.unsplash.com/photos/random?orientation=landscape"
    
    // MARK: FUNCTIONS
    
    // MARK: - Fetch Random Image URL
    func fetchRandomImageURLString() async throws -> String? {
        guard let url = URL(string: randomPhotoURLString) else {
            print("Invalid URL")
            return nil
        }
        
        let response = try await networkCall(url, UnsplashPhotoModel.self)
        return response.photo.urlString
    }
    
    // MARK: - Fetch Array of Query Image URLs
    private func fetchQueryImageURLStringsArray(_ queryText: String) async throws -> [String] {
        guard let queryURLString = try await getNextAvailableQueryURLString(queryText),
              let url = URL(string: queryURLString) else {
            print("Invalid URL")
            return []
        }
        
        let response = try await networkCall(url, SearchPhotoModel.self)
        let urlStringsArray: [String] = response.results.compactMap({ $0.photo.urlString })
        return urlStringsArray
    }
    
    // MARK: - URL Session Network Call Request
    private func networkCall<T: Decodable>(_ url: URL, _ type: T.Type) async throws -> T {
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(type, from: data)
        
        return response
    }
    
    // MARK: - Get Temporary Query URL String
    private func getTempQueryURLString(_ pageNumber: Int, _ queryText: String) -> String {
        return "https://api.unsplash.com/search/photos?orientation=landscape&page=\(pageNumber)&per_page=10&query=\(queryText)"
    }
    
    // MARK: - Get Next Available Query URL String
    private func getNextAvailableQueryURLString(_ queryText: String) async throws -> String? {
        let queryURLsSet: Set<String> = try await fileStorageManager.loadURLs(.queryURLs, queryText)
        guard !queryURLsSet.isEmpty else {
            let queryURLString: String = getTempQueryURLString(1, queryText)
            return queryURLString
        }
        
        for pageIndex in 1...100 {
            let urlString: String = getTempQueryURLString(pageIndex, queryText)
            let isContain: Bool = queryURLsSet.contains(urlString)
            
            if isContain {
                continue
            } else {
                return urlString
            }
        }
        
        return nil
    }
    
    // MARK: - Get Next Available Image URL String
    private func getNextAvailableQueryImageURLString(_ queryText: String) async throws -> String? {
        let preSavedImageURLStringsSet: Set<String> = try await fileStorageManager.loadURLs(.preSavedURLs, queryText)
        guard !preSavedImageURLStringsSet.isEmpty else {
            return nil
        }
        
        return preSavedImageURLStringsSet.first
    }
    
    // MARK: - Fetch Query Image URL String
    func fetchQueryImageURLString(_ queryText: String) async throws -> String? {
        guard let queryImageURLString: String = try await getNextAvailableQueryImageURLString(queryText) else {
            var urlStringsArray: [String] =  try await fetchQueryImageURLStringsArray(queryText)
            let urlString = urlStringsArray.first
            urlStringsArray.removeFirst()
            try await fileStorageManager.saveURLs(.preSavedURLs, queryText, Set(urlStringsArray))
            return urlString
        }
        
        return queryImageURLString
    }
}
