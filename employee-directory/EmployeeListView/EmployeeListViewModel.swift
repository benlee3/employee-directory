//
//  EmployeeListViewModel.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import CoreData
import Foundation
import UIKit

extension GetEmployeesRequest: GetEmployeesRequestProvider {
    func request() -> GetEmployeesRequestProvider {
        return GetEmployeesRequest()
    }
}

class EmployeeListViewModel: BindableViewModel {
    var store: Store<AppState, AppAction, CoordinatorEffect>
    var cancellables = Set<AnyCancellable>()
    var getEmployeeRequestProvider: GetEmployeesRequestProvider
    var persistentContainer: NSPersistentContainer
    
    @Published var viewState: ViewState = .notLoaded
    @Published var employees: [Employee]?
    
    required init(store: Store<AppState, AppAction, CoordinatorEffect>,
                  getEmployeeRequestProvider: GetEmployeesRequestProvider = GetEmployeesRequest(),
                  persistentContainer: NSPersistentContainer) {
        self.store = store
        self.getEmployeeRequestProvider = getEmployeeRequestProvider
        self.persistentContainer = persistentContainer
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
        var employees: [Employee]
        // read from disk
        let fetchRequest = NSFetchRequest<EmployeeModel>(entityName: "EmployeeModel")
        do {
            let employeeModels = try persistentContainer.viewContext.fetch(fetchRequest)
            employees = try employeeModels.map {
                guard let employeeType = $0.employeeType else { throw NSError() }
                let employee = Employee.init(id: $0.id ?? "", fullName: $0.fullName ?? "", phoneNumber: $0.phoneNumber, emailAddress: $0.emailAddress ?? "", biography: $0.biography, photoURLSmall: $0.photoURLSmall, photoURLLarge: $0.photoURLLarge, team: $0.team ?? "", employeeType: Employee.EmployeeType(rawValue: employeeType) ?? Employee.EmployeeType.fullTime)
                return employee
            }
            self.store.send(.setEmployees(employees))
            if employees.isEmpty {
                self.viewState = .incomplete
            } else {
                self.viewState = .completed
                return // successfully pulled data from disk
            }
        } catch {
            print("failed to pull data from disk")
        }
        
        // make network call
        getEmployeeRequestProvider.execute(urlSession: .shared)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self?.viewState = .error(error.localizedDescription)
                }
            }, receiveValue: { [weak self] response in
                guard let strongSelf = self else { return }
                //save to disk and then set in memory
                let employeeModels: [EmployeeModel] = response.employees.map {
                    let employeeModel = EmployeeModel(context: strongSelf.persistentContainer.viewContext)
                    employeeModel.biography = $0.biography
                    employeeModel.emailAddress = $0.emailAddress
                    employeeModel.employeeType = $0.employeeType.rawValue
                    employeeModel.fullName = $0.fullName
                    employeeModel.id = $0.id
                    employeeModel.phoneNumber = $0.phoneNumber
                    employeeModel.photoURLLarge = $0.photoURLLarge
                    employeeModel.photoURLSmall = $0.photoURLSmall
                    employeeModel.team = $0.team
                    return employeeModel
                }
                do {
                    try strongSelf.persistentContainer.viewContext.save()
                } catch {
                    print("error while writing to disk")
                    print("response: \(response)")
                }
                
                self?.store.send(.setEmployees(response.employees))
                if response.employees.isEmpty {
                    self?.viewState = .incomplete
                } else {
                    self?.viewState = .completed
                }
                
            })
            .store(in: &cancellables)
    }
    
    func employeeSelected(index: Int) {
        store.send(.employeeSelected(index))
    }
}
