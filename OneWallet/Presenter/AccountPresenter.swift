//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import Foundation

protocol AccountView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setAccount(_ account: AccountViewData)
    func setNoAccount()
}

class AccountPresenter {
    fileprivate let serviceLayer:ServiceLayer
    weak fileprivate var accountView : AccountView?
    
    init(serviceLayer:ServiceLayer){
        self.serviceLayer = serviceLayer
    }
}

// #6 TODO: what is most efficient way to use delegate functions in this architecture 

extension AccountPresenter {
    
    func attachView(_ view:AccountView){
        accountView = view
    }
    
    func detachView() {
        accountView = nil
    }
    
    // #7 TODO: seems like this is redundant function - object already mapped in service layer 
    
    func getAccount(accountIdentifier: String){
        self.accountView?.startLoading()
        serviceLayer.getAccount(accountIdentifier: accountIdentifier){ [weak self] account in
            self?.accountView?.finishLoading()
            if account == nil {
                self?.accountView?.setNoAccount()
            } else {
                let mappedAccount = AccountViewData(institutionImage: account.institutionImage, id: account.id, balance: account.balance, name: account.name, transactions: account.transactions)
                self?.accountView?.setAccount(mappedAccount)
            }
            
        }
    }
}
