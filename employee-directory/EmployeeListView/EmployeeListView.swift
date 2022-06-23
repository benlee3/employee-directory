//
//  EmployeeListView.swift
//  employee-directory
//
//  Created by Ben Lee on 6/18/22.
//

import Foundation
import UIKit

class EmployeeListView: UIView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 400, height: 400)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(EmployeeListCell.self, forCellWithReuseIdentifier: "EmployeeCell")
        cv.setContentHuggingPriority(.defaultLow, for: .vertical)
        cv.backgroundColor = .clear
        cv.refreshControl = UIRefreshControl()
        return cv
    }()
    
    lazy var errorView: UIStackView = {
        let stack = UIStackView(alignment: .center, axis: .vertical, distribution: .equalCentering, spacing: 10)
        let imageView = UIImageView(image: UIImage(systemName: "xmark.octagon"))
        imageView.tintColor = .black
        let label = UILabel()
        label.text = "There was an error!"
        stack.addArrangedSubviews(imageView, label)
        return stack
    }()
    
    lazy var noResultsView: UIStackView = {
        let stack = UIStackView(alignment: .center, axis: .vertical, distribution: .equalCentering, spacing: 10)
        let imageView = UIImageView(image: UIImage(systemName: "person.fill.xmark"))
        imageView.tintColor = .black
        let label = UILabel()
        label.text = "No employees found!"
        stack.addArrangedSubviews(imageView, label)
        return stack
    }()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.addSubviewAndAnchor(collectionView,
                                 top: self.safeAreaLayoutGuide.topAnchor,
                                 leading: self.safeAreaLayoutGuide.leadingAnchor,
                                 bottom: self.bottomAnchor,
                                 trailing: self.safeAreaLayoutGuide.trailingAnchor)
        self.addSubviewAndAnchor(activityIndicator,
                                 centerX: self.centerXAnchor,
                                 centerY: self.centerYAnchor)
    }
    
    func showList() {
        self.collectionView.refreshControl?.endRefreshing()
        self.collectionView.isHidden = false
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
    }
    
    func showActivityIndicator() {
        self.activityIndicator.isHidden = false
        self.collectionView.isHidden = true
        self.activityIndicator.startAnimating()
    }
    
    func showErrorView() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.collectionView.isHidden = true
        self.addSubviewAndAnchor(errorView,
                                 centerX: self.centerXAnchor,
                                 centerY: self.centerYAnchor)
    }
    
    func showNoResultsView() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.collectionView.isHidden = true
        self.addSubviewAndAnchor(noResultsView,
                                 centerX: self.centerXAnchor,
                                 centerY: self.centerYAnchor)
    }
}
