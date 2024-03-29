//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

class Container: UIViewController {
    
    // Presenter
    fileprivate var containerPresenter: ContainerPresenter!
    
    // ViewControllers
    fileprivate var sidePanelController: SidePanelViewController
    fileprivate var accountController: AccountViewController
    fileprivate var addBankVC: AddBankViewController

    init(_ containerPresenter: ContainerPresenter) {
        
        // Presenter
        self.containerPresenter = containerPresenter
        
        // ViewControllers
        self.sidePanelController = containerPresenter.sidePanelVC
        self.accountController = containerPresenter.accountVC
        self.addBankVC = containerPresenter.addBankVC
        
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Presenter Setup
        containerPresenter.setup(container: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Layout SidePanelVC and AccountVC in ContainerVC
        containerPresenter.layout()
    }
}
