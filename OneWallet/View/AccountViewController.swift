//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Presenter
    
    fileprivate var accountPresenter: AccountPresenter!
    
    // Data
    
    fileprivate var accountToDisplay = AccountViewData()
    
    var selectedAccount: String?
    
    weak var delegate: ContainerDelegate?
    
    // Outlets
    
    @IBOutlet weak var institutionDetailImage: UIImageView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70

        activityIndicator?.hidesWhenStopped = true
        
        accountPresenter.attachView(self)
        accountPresenter.getAccount(accountIdentifier: selectedAccount!)
    }
    
    func configure(with presenter: AccountPresenter, selected: String) {
        self.accountPresenter = presenter
        self.selectedAccount = selected
    }
    // Actions

    @IBAction func sidePanelButton(_ sender: Any) {
        delegate?.didTapMenuButton()
    }
    
    // Present Data
    
    func setup() {
        institutionDetailImage.image = accountToDisplay.institutionImage
        balanceLabel.text = String(Int((accountToDisplay.balance)!))
        accountLabel.text = accountToDisplay.name
    }
}

// Table View Data Source

extension AccountViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(accountToDisplay)
        if let a = accountToDisplay.transactions {
            return a.count }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.setup((accountToDisplay.transactions![indexPath.row]))
        return cell
    }
}

extension AccountViewController: AccountView {

    func startLoading() {
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
    
    func setAccount(_ account: AccountViewData) {
        accountToDisplay = account
        tableView?.isHidden = false
//        emptyView?.isHidden = true;
        tableView?.reloadData()
        setup()
    }
    
    func setNoAccount() {
        tableView?.isHidden = true
//        emptyView?.isHidden = false;
    }
}

