//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import Foundation
import Alamofire
import AlamofireObjectMapper

//    #8 TODO: Data Loading
//    Should I be loading all accounts with transactions fully in the beginning?

//    #9 TODO: Mapping
//    I parse API data in backend before sending to iOS App
//    Is it necessary to map from json to model and then to another model? – could this be useful layer in future?

//    #10 TODO: Presistent Data
//    Add persistent data services – Core Data? Realm DB?

class ServiceLayer {

    //    the service currently delivers mocked data with a delay
    
    func getAccount(accountIdentifier: String, _ callBack:@escaping (Account) -> Void){

        var account: Account?

        if accountIdentifier == "0" {
            let transaction = Transaction(name: "from Max", date: "18-06-01", amount: 20.00, id: "1")
            let transaction1 = Transaction(name: "to Jason", date: "18-06-02", amount: 14.20, id: "2")
            let transaction2 = Transaction(name: "from Max", date: "18-06-01", amount: 20.00, id: "1")
            let transaction3 = Transaction(name: "to Jason", date: "18-06-02", amount: 14.20, id: "2")

            account = Account(institutionImage: UIImage(named: "BofA"), id: "1234", balance: 14.80, name: "BofA Checkings", transactions: [transaction!, transaction1!])
        } else if accountIdentifier == "1" {
            let transaction = Transaction(name: "from Josh", date: "18-05-05", amount: 12.00, id: "1")
            let transaction1 = Transaction(name: "to Aron", date: "18-05-13", amount: 17.14, id: "2")
            account = Account(institutionImage: nil, id: "1234", balance: 5.80, name: "BofA Savings", transactions: [transaction!, transaction1!])
        } else {
            let transaction = Transaction(name: "from Daren", date: "18-03-01", amount: 13.00, id: "1")
            let transaction1 = Transaction(name: "to Sarah", date: "18-06-21", amount: 30.14, id: "2")
            let transaction2 = Transaction(name: "to Bill", date: "17-06-02", amount: 01.14, id: "3")
            account = Account(institutionImage: nil, id: "1234", balance: 5.80, name: "Wells Fargo Savings", transactions: [transaction!, transaction1!, transaction2!])
        }

        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(account!)
        }
    }
    
//    func getAccount(accountIdentifier: String, _ callBack:@escaping (Account) -> Void){
//        Alamofire.request("http://js.local:8000/account", method: .post, encoding: JSONEncoding.default).responseObject { (response: DataResponse<Account>) in
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let account = response.result.value {
//                callBack(account)
//            } else {
//                print("service error")
//            }
//
//        }
//    }
    
    func getAccountsReferences(_ callBack:@escaping (AccountsReferences) -> Void){
        let accountReference = AccountReference(id: "0", name: "BofA Checking", institution: "BofA")
        let accountReference1 = AccountReference(id: "1", name: "BofA Savings", institution: "Citi")
        let accountsReferences = AccountsReferences(accountsReferences:[accountReference!, accountReference1!])
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(accountsReferences!)
        }
    }
    
//    func getAccountsReferences(_ callBack:@escaping (AccountsReferences) -> Void){
//        Alamofire.request("http://js.local:8000/accountsReference", method: .post, encoding: JSONEncoding.default).responseObject { (response: DataResponse<AccountsReferences>) in
//
//            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
//            }
//
//            if let accountsReferences = response.result.value {
//                callBack(accountsReferences)
//            } else {
//                print("service error")
//            }
//
//        }
//    }
    

    func addNewAccount(new: AddBankModel, _ callBack:@escaping (AccountsReferences) -> Void) {
        
        let accountReference = AccountReference(id: "0", name: "BofA Checking", institution: "BofA")
        let accountReference1 = AccountReference(id: "1", name: "BofA Savings", institution: "BofA")
        let accountReference2 = AccountReference(id: "2", name: "Wells Fargo Savings", institution: "WF")
        let accountsReferences = AccountsReferences(accountsReferences:[accountReference!, accountReference1!, accountReference2!])
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(accountsReferences!)
        }
        
    }
    
//    func addNewAccount(new: AddBankModel, _ callBack:@escaping (AccountsReferences) -> Void) {
//
//        let params: Parameters = ["publicToken": new.publicToken, "accountIdentifier": new.accountIdentifier]
//
//        Alamofire.request("http://js.local:8000/newAccount", method: .post, parameters: params, encoding: JSONEncoding.default).responseObject { (response: DataResponse<AccountsReferences>) in
//
//            if let accountsReferences = response.result.value {
//                callBack(accountsReferences)
//            } else {
//                print("service error")
//            }
//
//        }
//    }
    
    
}
