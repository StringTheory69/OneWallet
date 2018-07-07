//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import Foundation

// Side Panel Presenter

protocol SidePanelView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setAccount(_ account: SidePanelViewData)
    func setNoAccount()
}

class SidePanelPresenter: NSObject {
    
    // side panel header
    var username: String?
    // is user signed in?
    var status: Bool?
    
    // Accounts
    var accounts: SidePanelViewData?
    var selected: String?
    
    // Account Presenter
    var accountPresenter: AccountPresenter!
    
    // Service Layer
    fileprivate let serviceLayer:ServiceLayer
    
    weak fileprivate var sidePanelView : SidePanelView?
    
    init(serviceLayer:ServiceLayer, accountPresenter:AccountPresenter){
        self.serviceLayer = serviceLayer
        self.accountPresenter = AccountPresenter(serviceLayer: serviceLayer)
    }
    
}

// delegate functions

extension SidePanelPresenter {
    
    func attachView(_ view:SidePanelView){
        sidePanelView = view
    }
    
    func detachView() {
        sidePanelView = nil
    }
    
    // seems like this is redundant function - object mapped in service layer - suggestions?

    func getAccount(){
        self.sidePanelView?.startLoading()
        serviceLayer.getAccountsReferences{ [weak self] accountsReferences in
            self?.sidePanelView?.finishLoading()
            if accountsReferences == nil {
                self?.sidePanelView?.setNoAccount()
            } else {
                let mappedAccounts =  SidePanelViewData(accounts: accountsReferences.accountsReferences)
                
                // selected is just first account in array for now
                self?.selected = accountsReferences.accountsReferences![0].id
                
                self?.sidePanelView?.setAccount(mappedAccounts)
            }
            
        }
    }
}
