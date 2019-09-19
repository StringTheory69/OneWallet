//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit
import WebKit

class AddBankPresenter: NSObject, WKNavigationDelegate {
    
    let webView = WKWebView()
    
    var delegate: ContainerPresenter?
    
    fileprivate let serviceLayer:ServiceLayer
    
    init(serviceLayer:ServiceLayer){
        self.serviceLayer = serviceLayer
    }
    
    func newAccount(_ new: AddBankModel) {
        serviceLayer.addNewAccount(new: new){ [weak self] accountReferences in
            print(accountReferences.toJSON())
            let updatedData = SidePanelViewData(accounts: accountReferences.accountsReferences)
            self?.delegate?.sidePanelVC.setAccount(updatedData)
        }
    }
    
    // getUrlParams :: parse query parameters into a Dictionary
    func getUrlParams(url: URL) -> Dictionary<String, Any> {
        var paramsDictionary = [String: Any]()
        let queryItems = URLComponents(string: (url.absoluteString))?.queryItems
        queryItems?.forEach { paramsDictionary[$0.name] = $0.value
        }
        return paramsDictionary
    }
    
    // generateLinkInitializationURL :: create the link.html url with query parameters
    func generateRequest() -> URLRequest {
        let config = [
            "key": "key",
            "env": "development",
            "apiVersion": "v2", // set this to "v1" if using the legacy Plaid API
            "product": "transactions, auth",
            "selectAccount": "true",
            "clientName": "Test App",
            "isMobile": "true",
            "isWebview": "true",
            "webhook": "https://requestb.in",
            ]
        
        // Build a dictionary with the Link configuration options
        // See the Link docs (https://plaid.com/docs/quickstart) for full documentation.
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn.plaid.com"
        components.path = "/link/v2/stable/link.html"
        components.queryItems = config.map { URLQueryItem(name: $0, value: $1) }
        let url = URL(string: components.string!)
        let request = URLRequest(url: url!)
        return request
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        
        let linkScheme = "plaidlink";
        let actionScheme = navigationAction.request.url?.scheme;
        let actionType = navigationAction.request.url?.host;
        let queryParams = getUrlParams(url: navigationAction.request.url!)
        
        if (actionScheme == linkScheme) {
            switch actionType {
                
            case "connected"?:
                
                //STORE IN FIREBASE DATABASE UPDATE MODELS IN APP
                
                // send Public Token: queryParams["public_token" & Account ID: queryParams["account_id"]
                guard let pub = queryParams["public_token"] as? String, let acc = queryParams["account_id"] as? String else {return}
                
                let newBankAccount = AddBankModel(publicToken: pub, accountIdentifier: acc)
                newAccount(newBankAccount) // store in FB and in app models
                print("Public Token: \(queryParams["public_token"])");
                print("Account ID: \(queryParams["account_id"])");
                print("Institution type: \(queryParams["institution_type"])");
                print("Institution name: \(queryParams["institution_name"])");
                delegate?.removeView()
                break
                
            case "exit"?:

                delegate?.removeView()
                // Close the webview
//                _ = self.navigationController?.popViewController(animated: true)
                
                // Parse data passed from Link into a dictionary
                // This includes information about where the user was in the Link flow
                // any errors that occurred, and request IDs
                print("URL: \(navigationAction.request.url?.absoluteString)")
                // Output data from Link
                print("User status in flow: \(queryParams["status"])");
                // The requet ID keys may or may not exist depending on when the user exited
                // the Link flow.
                print("Link request ID: \(queryParams["link_request_id"])");
                print("Plaid API request ID: \(queryParams["link_request_id"])");
                break
                
            default:
                print("Link action detected: \(actionType)")
                break
            }
            
            decisionHandler(.cancel)
        } else if (navigationAction.navigationType == WKNavigationType.linkActivated &&
            (actionScheme == "http" || actionScheme == "https")) {
            // Handle http:// and https:// links inside of Plaid Link,
            // and open them in a new Safari page. This is necessary for links
            // such as "forgot-password" and "locked-account"
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            print("Unrecognized URL scheme detected that is neither HTTP, HTTPS, or related to Plaid Link: \(navigationAction.request.url?.absoluteString)");
            
            //MARK: for testing purposes when webview doesn't work it triggers test new account function
            let newBankAccount = AddBankModel(publicToken: "public", accountIdentifier: "account")
            newAccount(newBankAccount) // store in FB and in app models
            
            // remove VC
            delegate?.removeView()

            decisionHandler(.allow)
        }
        
        
    }
}
