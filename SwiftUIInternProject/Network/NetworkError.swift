//
//  NetworkError.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 19..
//

import Foundation

enum NetworkError: Error {
    case invalidURL(endpoint: String)
    case encodingFailed(innerError: EncodingError)
    case decodingFailed(innerError: DecodingError)
    case invalidStatusCode(statusCode: Int)
    case requestFailed(innerError: URLError)
    case otherError(innerError: Error)
}
