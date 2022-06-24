//
//  EmployeeDetailViewController.swift
//  employee-directory
//
//  Created by Ben Lee on 6/23/22.
//

import Foundation
import UIKit

class EmployeeDetailViewController: UIViewController {
    var employeeDetailView = EmployeeDetailView()
    var viewModel: EmployeeDetailViewModel
    
    init(viewModel: EmployeeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = employeeDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeDetailView.nameLabel.text = viewModel.name
        employeeDetailView.phoneLabel.text = viewModel.phoneNumber
        employeeDetailView.emailLabel.text = viewModel.emailAddress
        employeeDetailView.biographyLabel.text = viewModel.biography
        employeeDetailView.employeeTypeLabel.text = viewModel.employeeType
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        employeeDetailView.setupView()
        viewModel.retrieveLargeImage(view: employeeDetailView)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        employeeDetailView.setupView()
    }
}
