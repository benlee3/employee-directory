//
//  MockNavigationController.swift
//  employee-directoryTests
//
//  Created by Ben Lee on 6/24/22.
//

import XCTest

class MockNavigationController: UINavigationController {
    var pushedViewControllers: [UIViewController] = []
    var presentedViewControllers: [UIViewController] = []
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewControllers.append(viewController)
        super.pushViewController(viewController, animated: false)
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedViewControllers.append(viewControllerToPresent)
        super.present(viewControllerToPresent, animated: flag)
    }
}
