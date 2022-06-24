//
//  EmployeeDetailViewModel.swift
//  employee-directory
//
//  Created by Ben Lee on 6/23/22.
//

import Combine
import Foundation
import Kingfisher
import UIKit

class EmployeeDetailViewModel {
    var selectedEmployee: Employee
    
    var name: String {
        selectedEmployee.fullName
    }
    
    var phoneNumber: String? {
        guard var phoneNum = selectedEmployee.phoneNumber, phoneNum.count == 10 else { return selectedEmployee.phoneNumber }
        phoneNum.insert("(", at: phoneNum.startIndex)
        phoneNum.insert(")", at: phoneNum.index(phoneNum.startIndex, offsetBy: 4))
        phoneNum.insert("-", at: phoneNum.index(phoneNum.startIndex, offsetBy: 5))
        phoneNum.insert("-", at: phoneNum.index(phoneNum.startIndex, offsetBy: 9))
        return phoneNum
    }
    
    var emailAddress: String {
        selectedEmployee.emailAddress
    }
    
    var biography: String? {
        selectedEmployee.biography
    }
    
    var teamName: String {
        selectedEmployee.team
    }
    
    var employeeType: String {
        switch selectedEmployee.employeeType {
        case .contractor:
            return "Contractor"
        case .fullTime:
            return "Full Time"
        case .partTime:
            return "Part Time"
        }
    }
    
    required init(employee: Employee) {
        self.selectedEmployee = employee
    }
    
    func retrieveLargeImage(view: EmployeeDetailView) {
        guard let url = selectedEmployee.photoURLLarge else { return }
        let roundedCornerProcessor = RoundCornerImageProcessor(cornerRadius: 1000, backgroundColor: .clear)
        let diameter = view.frame.size.width * 0.40
        view.employeeImage.anchor(width: diameter, height: diameter)
        view.employeeImage.kf.setImage(with: URL(string: url), options: [ .processor(roundedCornerProcessor)])
    }
    
}
