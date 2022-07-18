//
//  Coordinator.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import CoreData
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
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmployeeDirectory")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
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
        let vc = EmployeeListViewController(viewModel: EmployeeListViewModel(store: self.store, persistentContainer: persistentContainer))
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func presentEmployeeDetails(index: Int) {
        guard let employee = store.value.employees[safe: index] else { return }
        let employeeDetailViewController = EmployeeDetailViewController(viewModel: EmployeeDetailViewModel(employee: employee))
        employeeDetailViewController.modalPresentationStyle = .formSheet
        navigationController.present(employeeDetailViewController, animated: true)
    }
    
    
}

enum CoordinatorEffect: Equatable {
    case showList
    case showEmployee(Int)
}
