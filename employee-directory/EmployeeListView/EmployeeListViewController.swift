//
//  EmployeeListViewController.swift
//  employee-directory
//
//  Created by Ben Lee on 6/17/22.
//

import Combine
import Kingfisher
import UIKit

class EmployeeListViewController: UIViewController {
    let employeeListView = EmployeeListView()
    let viewModel: EmployeeListViewModel
    var cancellables = Set<AnyCancellable>()
    weak var coordinator: Coordinator?
    
    init(viewModel: EmployeeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = employeeListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        employeeListView.collectionView.dataSource = self
        employeeListView.collectionView.delegate = self
        employeeListView.collectionView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        viewModel.retrieveAllEmployees()
        bindToViewModel()
        setupNavigationBar()
    }
    
    override func viewWillLayoutSubviews() {
        employeeListView.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func bindToViewModel() {
        viewModel.$employees.sink { [unowned self] _ in
            DispatchQueue.main.async {
                self.employeeListView.collectionView.reloadData()
            }
        }.store(in: &cancellables)
        
        self.viewModel.$viewState.sink { [unowned self] viewState in
            DispatchQueue.main.async {
                switch viewState {
                case .loading:
                    self.employeeListView.showActivityIndicator()
                case .completed:
                    self.employeeListView.showList()
                case .error(let error):
                    print("error") // log error here
                    self.employeeListView.showErrorView()
                case .incomplete:
                    self.employeeListView.showNoResultsView()
                default:
                    break
                }
            }
        }.store(in: &cancellables)
    }
    
    func setupNavigationBar() {
        self.navigationItem.title = "Our Team"
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refresh)), animated: true)
    }
    
    @objc func refresh() {
        viewModel.retrieveAllEmployees()
    }
}

extension EmployeeListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width
        let height = view.frame.size.height
        if traitCollection.horizontalSizeClass == .compact {
            return CGSize(width: (width - 30)/2, height: height / 3)
        } else {
            return CGSize(width: (width - 30)/2, height: height / 3)
        }
        
    }
}

extension EmployeeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.employeeSelected(index: indexPath.row)
    }
}

extension EmployeeListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.employees?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmployeeCell", for: indexPath) as? EmployeeListCell,
              let employees = viewModel.employees else { return UICollectionViewCell() }
        cell.setupCell(employee: employees[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let cell = cell as? EmployeeListCell,
            let employees = viewModel.employees,
            let url = employees[indexPath.row].photoURLSmall
        else { return }
        
        cell.retrieveImage(for: url)
    }
}
