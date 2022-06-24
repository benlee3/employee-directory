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
