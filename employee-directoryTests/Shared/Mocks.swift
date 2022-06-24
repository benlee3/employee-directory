//
//  Mocks.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

@testable import employee_directory
import XCTest

struct Mocks {
    static let employeeAllFields = Employee(id: "abc123",
                                   fullName: "Ben Lee",
                                   phoneNumber: "1234567890",
                                   emailAddress: "ben@square.com",
                                   biography: "I am a developer",
                                   photoURLSmall: "www.google.com",
                                   photoURLLarge: "www.googlegoogle.com",
                                   team: "iPhone",
                                   employeeType: .partTime)
    static let twoEmployees: [Employee] = [
        Employee(id: "0d8fcc12-4d0c-425c-8355-390b312b909c",
                 fullName: "Justine Mason",
                 phoneNumber: "5553280123",
                 emailAddress: "jmason.demo@squareup.com",
                 biography: "Engineer on the Point of Sale team.",
                 photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
                 photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
                 team: "Point of Sale",
                 employeeType: .fullTime),
        Employee(id: "a98f8a2e-c975-4ba3-8b35-01f719e7de2d",
                 fullName: "Camille Rogers",
                 phoneNumber: "5558531970",
                 emailAddress: "crogers.demo@squareup.com",
                 biography: "Designer on the web marketing team.",
                 photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg",
                 photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg",
                 team: "Public Web & Marketing",
                 employeeType: .partTime)
    ]
    
    static let initialStoreValueWithEmployee: AppState = AppState(employees: [Mocks.employeeAllFields])
    
    struct MockDataURLResponder: MockURLResponder {
        static let mockResponse = GetEmployeesResponse(employees: Mocks.twoEmployees)
        
        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(mockResponse)
        }
    }
    
    struct MalformedMockDataURLResponder: MockURLResponder {
        static let mockResponse = """
{ "employees" : "bad format" }
"""
        
        static func respond(to request: URLRequest) throws -> Data {
            return try JSONEncoder().encode(mockResponse)
        }
    }
}
