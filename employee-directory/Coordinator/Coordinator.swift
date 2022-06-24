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
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
//    func handleAction<NavSideEffect>(action: NavSideEffect)
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var store: Store<AppState, AppAction, CoordinatorAction>
    var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController,
         store: Store<AppState, AppAction, CoordinatorAction>) {
        self.navigationController = navigationController
        self.store = store
    }
    
    func start() {
        let vc = EmployeeListViewController(viewModel: EmployeeListViewModel(store: self.store))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func handleAction(action: CoordinatorAction) {
//        switch
        print()
    }
    
    func presentEmployeeDetails(index: Int) {
        let employeeDetailViewController = EmployeeDetailViewController(viewModel: EmployeeDetailViewModel(employee: store.value.employees[index]))
        employeeDetailViewController.modalPresentationStyle = .formSheet
        navigationController.present(employeeDetailViewController, animated: true)
    }
    
    
}

enum CoordinatorAction {
    case showEmployee
}
