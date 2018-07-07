//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import Foundation

struct AddBankModel {
    var publicToken: String?
    var accountIdentifier: String?
    
    init(publicToken: String, accountIdentifier: String) {
        self.publicToken = publicToken
        self.accountIdentifier = accountIdentifier
    }
}
