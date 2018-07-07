//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import Foundation
import UIKit

protocol ContainerDelegate: class {
    func didTapMenuButton()
    func addBankView()
    func removeView()
}

class ContainerPresenter {
    
    let bounds = UIScreen.main.bounds

    var isMenuExpanded: Bool = false

    // Services
    var serviceLayer: ServiceLayer?
    
    // Presenters
    var accountPresenter: AccountPresenter?
    var sidePanelPresenter: SidePanelPresenter?
    var addBankPresenter: AddBankPresenter?
    
    // ViewControllers
    var sidePanelVC: SidePanelViewController
    var addBankVC: AddBankViewController
    var accountVC: AccountViewController
    
    init(_ serviceLayer: ServiceLayer) {
        
        // services
        self.serviceLayer = serviceLayer
        
        accountPresenter = AccountPresenter(serviceLayer: serviceLayer)
        sidePanelPresenter = SidePanelPresenter(serviceLayer: serviceLayer, accountPresenter: accountPresenter!)
        addBankPresenter = AddBankPresenter(serviceLayer: serviceLayer)

        // SidePanel
        sidePanelVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SidePanelViewController") as! SidePanelViewController
        sidePanelVC.configure(with: sidePanelPresenter!)
        
        // AccountVC
        accountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
        accountVC.configure(with: (sidePanelPresenter?.accountPresenter)!, selected: "0")
        
        // Add Bank Account
        
        addBankVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddBankViewController") as! AddBankViewController)
        addBankVC.configure(with: addBankPresenter!)
        
        accountVC.delegate = self
        sidePanelVC.delegate = self
        
    }
}

// VC Logic

extension ContainerPresenter {
    
    func setup(container: Container) {
        container.addChildViewController(sidePanelVC)
        container.view.addSubview(sidePanelVC.view)
        sidePanelVC.didMove(toParentViewController: container)
        
        container.addChildViewController(accountVC)
        container.view.addSubview(accountVC.view)
        accountVC.didMove(toParentViewController: container)

        configureGestures()
    }
    
    func layout() {
        let width: CGFloat = (isMenuExpanded) ? bounds.width * 2/3: 0.0
        self.accountVC.view.frame = CGRect(x: width, y: 0, width: self.accountVC.view.bounds.width, height: bounds.height)
    }
    
    func toggleMenu() {
        
        isMenuExpanded = !isMenuExpanded

        let width: CGFloat = (isMenuExpanded) ? bounds.width * 2/3: 0.0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.accountVC.view.frame = CGRect(x: width, y: 0, width: self.accountVC.view.bounds.width, height: self.bounds.height)
        }) { (success) in
        }
    }
    
    func configureGestures() {
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeLeftGesture.direction = .left
        sidePanelVC.view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
        swipeRightGesture.direction = .right
        accountVC.view.addGestureRecognizer(swipeRightGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOverlay))
        accountVC.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc fileprivate func didSwipe() {
        toggleMenu()
    }
    
    @objc fileprivate func didTapOverlay() {
        if isMenuExpanded {
            toggleMenu()
        }
    }
}

// Side Panel Delegate

extension ContainerPresenter: ContainerDelegate {
    
    // MARK: how do I make this reusable code?
    
    func didTapMenuButton() {
        toggleMenu()
    }
    
    // View Manager Delegate

    func addBankView() {
        addBankVC.addBankPresenter.delegate = self
        sidePanelVC.view.addSubview((addBankVC.view)!)
        sidePanelVC.addChildViewController(addBankVC)
        addBankVC.didMove(toParentViewController: sidePanelVC)
    }

    func removeView() {
        addBankVC.view.removeFromSuperview()
        addBankVC.removeFromParentViewController()
    }
}

