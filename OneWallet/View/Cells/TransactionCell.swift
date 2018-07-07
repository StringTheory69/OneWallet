//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

// Transaction Cell

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    func setup(_ transaction: Transaction) {
        nameLabel.text = transaction.name
        dateLabel.text = transaction.date
        amountLabel.text = String(Int(transaction.amount!))
    }
}
