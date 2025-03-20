//
//  TmdbApiClient.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 19..
//

import Foundation
import Combine

class TmdbApiClient {
    private let baseUrlString = "https://api.themoviedb.org/3"
    private let authToken: String
    
    public init(authToken: String) {
        self.authToken = authToken
    }
    
    private func performRequest<T: Decodable>(urlRequest: URLRequest, responseType: T.Type) async -> Result<T, NetworkError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(.invalidStatusCode(statusCode: -1))
            }
            guard (200...299).contains(statusCode) else {
                return .failure(.invalidStatusCode(statusCode: statusCode))
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try decoder.decode(T.self, from: data)
            
            return .success(decodedResponse)
        } catch let error as DecodingError {
            return .failure(.decodingFailed(innerError: error))
        } catch let error as URLError {
            return .failure(.requestFailed(innerError: error))
        } catch let error as NetworkError {
            return .failure(error)
        } catch {
            return .failure(.otherError(innerError: error))
        }
    }

    private func encodeRequestBody<T: Encodable>(_ requestBody: T) -> Result<Data, NetworkError> {
        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            return .success(jsonData)
        } catch let error as EncodingError {
            return .failure(.encodingFailed(innerError: error))
        } catch {
            return .failure(.otherError(innerError: error))
        }
    }
    
    public func get<T: Decodable>(endpoint: Endpoint, responseType: T.Type = T.self) async -> Result<T, NetworkError> {
        guard let url = getFetchUrl(endpoint: endpoint) else {
            return .failure(.invalidURL(endpoint: endpoint.path))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Method.get.rawValue
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        return await performRequest(urlRequest: request, responseType: responseType)
    }
    
    
    public func post<T: Encodable, U: Decodable>(endpoint: Endpoint, requestBody: T, responseType: U.Type = U.self) async -> Result<U, NetworkError> {
        guard let url = getFetchUrl(endpoint: endpoint) else {
            return .failure(.invalidStatusCode(statusCode: -1))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Method.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        
        switch encodeRequestBody(requestBody) {
        case .success(let jsonData):
            request.httpBody = jsonData
        case .failure(let error):
            return .failure(error)
        }
        
        return await performRequest(urlRequest: request, responseType: responseType)
    }
    
    private func getFetchUrl(endpoint: Endpoint) -> URL? {
        return URL(string: "\(baseUrlString)\(endpoint.path)")
    }
}
