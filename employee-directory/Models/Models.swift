//
//  Models.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Foundation

struct Employee: Codable, Equatable {
    let id: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoURLSmall: String?
    let photoURLLarge: String?
    let team: String
    let employeeType: EmployeeType
    
    enum EmployeeType: String, Codable {
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
        case contractor = "CONTRACTOR"
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}

// Was used prior to having networking code setup
//extension Employee {
//    static var employeeMocks: [Employee] = [
//        Employee(id: "0d8fcc12-4d0c-425c-8355-390b312b909c",
//                 fullName: "Justine Mason",
//                 phoneNumber: "5553280123",
//                 emailAddress: "jmason.demo@squareup.com",
//                 biography: "Engineer on the Point of Sale team.",
//                 photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg",
//                 photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg",
//                 team: "Point of Sale",
//                 employeeType: .fullTime),
//        Employee(id: "a98f8a2e-c975-4ba3-8b35-01f719e7de2d",
//                 fullName: "Camille Rogers",
//                 phoneNumber: "5558531970",
//                 emailAddress: "crogers.demo@squareup.com",
//                 biography: "Designer on the web marketing team.",
//                 photoURLSmall: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/small.jpg",
//                 photoURLLarge: "https://s3.amazonaws.com/sq-mobile-interview/photos/5095a907-abc9-4734-8d1e-0eeb2506bfa8/large.jpg",
//                 team: "Public Web & Marketing",
//                 employeeType: .partTime)
//    ]
//}

