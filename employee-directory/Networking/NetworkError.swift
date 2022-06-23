//
//  NetworkError.swift
//  employee-directory
//
//  Created by Ben Lee on 6/20/22.
//

import Foundation

enum NetworkError: Error {
    case apiError(String)
    case decodeError(String)
}
