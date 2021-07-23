//
//  NetworkErrors.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import Foundation

enum NetworkError:Error {
    case failed(error:Error)
    case invalidResponse(response:URLResponse)
    case emptyData
}
