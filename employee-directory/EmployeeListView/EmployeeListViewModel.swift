//
//  EmployeeListViewModel.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Foundation
import UIKit

class EmployeeListViewModel: ViewModel {
    var store: Store<AppState, AppAction>
    var cancellables = Set<AnyCancellable>()
    
    @Published var viewState: ViewState = .notLoaded
    @Published var employees: [Employee]?
    
    required init(store: Store<AppState, AppAction>) {
        self.store = store
        bindToState()
    }
    
    func bindToState() {
        self.employees = store.value.employees
        store.$value.sink { [weak self] state in
            if self?.employees != state.employees {
                self?.employees = state.employees
            }
        }.store(in: &cancellables)
    }
    
    func retrieveAllEmployees() {
        self.viewState = .loading
        GetEmployeesRequest().execute()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.viewState = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                self?.store.send(.setEmployees(response.employees))
                if response.employees.isEmpty {
                    self?.viewState = .incomplete
                } else {
                    self?.viewState = .completed
                }
            })
            .store(in: &cancellables)
    }
}
