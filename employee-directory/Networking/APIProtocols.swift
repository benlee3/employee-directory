//
//  APIProtocols.swift
//  employee-directory
//
//  Created by Ben Lee on 6/24/22.
//

import Combine
import Foundation

protocol APIRequest {
    associatedtype ResponseType
    func execute(urlSession: URLSession) -> AnyPublisher<Self.ResponseType, NetworkError>
}

protocol APIResponse { }
