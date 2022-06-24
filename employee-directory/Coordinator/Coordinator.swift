//
//  Coordinator.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation
import UIKit

protocol Coordinator: AnyObject {
//    var childCoordinators: [Coordinator] { get set } // not needed for this project
    var navigationController: UINavigationController { get set }
    func handleAction(action: CoordinatorEffect)
}

class AppCoordinator: Coordinator {
//    var childCoordinators = [Coordinator]() // not needed for this project
    var navigationController: UINavigationController
    var store: Store<AppState, AppAction, CoordinatorEffect>
    var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController,
         store: Store<AppState, AppAction, CoordinatorEffect>) {
        self.navigationController = navigationController
        self.store = store
    }
    
    func handleAction(action: CoordinatorEffect) {
        switch action {
        case .showList:
            showList()
        case .showEmployee(let index):
            presentEmployeeDetails(index: index)
        }
    }
    
    func showList() {
        let vc = EmployeeListViewController(viewModel: EmployeeListViewModel(store: self.store))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentEmployeeDetails(index: Int) {
        let employeeDetailViewController = EmployeeDetailViewController(viewModel: EmployeeDetailViewModel(employee: store.value.employees[index]))
        employeeDetailViewController.modalPresentationStyle = .formSheet
        navigationController.present(employeeDetailViewController, animated: true)
    }
    
    
}

enum CoordinatorEffect {
    case showList
    case showEmployee(Int)
}
