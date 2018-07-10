//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

class AddBankViewController: UIViewController {
    
    // Presenter
    
    var addBankPresenter: AddBankPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // load the link url
        let request = addBankPresenter.generateRequest()
        let webView = addBankPresenter.webView
 
        webView.navigationDelegate = addBankPresenter
        webView.allowsBackForwardNavigationGestures = false
        webView.frame = view.frame
        webView.scrollView.bounces = false
        self.view.addSubview(webView)
        webView.load(request)
    }
    
    func configure(with presenter: AddBankPresenter) {
        self.addBankPresenter = presenter
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

}

