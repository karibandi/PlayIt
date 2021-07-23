//
//  VideoModel.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import Foundation

struct VideoLibrary: Codable {
    let title: String
    let nodes: [Node]
}

struct Node: Codable {
    let video: Video
}

struct Video: Codable {
    let encodeURL: String

    enum CodingKeys: String, CodingKey {
        case encodeURL = "encodeUrl"
    }
}

typealias VideoStack = [VideoLibrary]
