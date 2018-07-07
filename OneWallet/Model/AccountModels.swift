//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import Foundation
import UIKit
import ObjectMapper

class Account: Mappable {
    var institutionImage: UIImage?
    var id: String?
    var balance: Double?
    var name: String?
    var transactions: [Transaction]?
    
    init?(institutionImage: UIImage?, id: String, balance: Double, name: String, transactions: [Transaction]) {
        self.institutionImage = institutionImage
        self.id = id
        self.balance = balance
        self.name = name
        self.transactions = transactions
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["account_id"]
        name <- map["name"]
        balance <- map["balance"]
        institutionImage <- map["institutionImage"]
        transactions <- map["transactions"]
    }
}

class Transaction: Mappable {
    
    var name: String?
    var date: String?
    var amount: Double?
    var id: String?
    
    init?(name: String, date: String, amount: Double, id: String) {
        self.name = name
        self.date = date
        self.amount = amount
        self.id = id
    }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["account_id"]
        name <- map["name"]
        date <- map["date"]
        amount <- map["amount"]
    }
}

struct AccountViewData {
    var institutionImage: UIImage?
    var id: String?
    var balance: Double?
    var name: String?
    var transactions: [Transaction]?
}

struct TransactionViewData {
    var nameLabel: UILabel?
    var amount : Double?
    var date: String?
    var name: String?
}


