//
//  Coordinator.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var store: Store<AppState, AppAction>
    var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController,
         store: Store<AppState, AppAction>) {
        self.navigationController = navigationController
        self.store = store
    }
    
    func start() {
        let vc = EmployeeListViewController(viewModel: EmployeeListViewModel(store: self.store))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func present() {
        
    }
    
}
