//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

class SidePanelViewController: UIViewController, UITableViewDelegate {
    
    // Presenter
    
    fileprivate var sidePanelPresenter: SidePanelPresenter!
    
    weak var delegate: ContainerDelegate?
        
    // Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator?.hidesWhenStopped = true
        sidePanelPresenter.attachView(self)
        sidePanelPresenter.getAccount()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.addBorder(edge: .top, color: UIColor.lightGray, thickness: 0.6)

    }
    
    func configure(with presenter: SidePanelPresenter) {
        self.sidePanelPresenter = presenter
    }
}

// Table View Data Source

// MARK: I need to deal with all this logic!

extension SidePanelViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Accounts"
        } else {
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if let a = sidePanelPresenter.accounts?.accounts {
                return a.count
            } else {
                return 0
            }
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidePanelCell", for: indexPath) as! SidePanelCell
        
        if indexPath.section == 1 {
            cell.setup((sidePanelPresenter.accounts?.accounts![indexPath.row])!)
            return cell
        } else  {
            cell.setRegulars(indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let id = sidePanelPresenter.accounts?.accounts![indexPath.row].id
            let selected = sidePanelPresenter.selected
        
            // MARK: check if selected Account is already open in AccountView
            
            if id != selected {
                sidePanelPresenter.selected = id
                sidePanelPresenter.accountPresenter.getAccount(accountIdentifier: id!)
            }
            delegate?.didTapMenuButton()
        } else {
            delegate?.addBankView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.backgroundView?.backgroundColor = UIColor.clear
        header?.textLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        header?.textLabel?.textColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
        header?.layer.addBorder(edge: .top, color: UIColor.lightGray, thickness: 0.6)
        header?.layer.addBorder(edge: .bottom, color: UIColor.lightGray, thickness: 0.6)

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 { return 44 }
        else { return 0 }
    }
}

extension SidePanelViewController: SidePanelView {
    
    func startLoading() {
        activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        activityIndicator?.stopAnimating()
    }
    
    func setAccount(_ accounts: SidePanelViewData) {
 
        sidePanelPresenter.accounts = accounts
        tableView?.isHidden = false
        tableView?.reloadData()
    }
    
    func setNoAccount() {
        tableView?.isHidden = true
    }

}



