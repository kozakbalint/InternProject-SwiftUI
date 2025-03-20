//
//  RatingResponse.swift
//  SwiftUIInternProject
//
//  Created by Balint Kozak on 2025. 03. 19..
//

import Foundation

public struct RatingResponse: Decodable {
    public let success: Bool
    public let statusCode: Int
    public let statusMessage: String
}
