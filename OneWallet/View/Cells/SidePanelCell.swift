//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

import UIKit

class SidePanelCell: UITableViewCell {
    
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var institutionImage: CircleImageView!
    
    func setRegulars(_ row: Int) {
        if row == 0 {
            accountNameLabel.text = "Profile"
        } else {
            accountNameLabel.text = "New Account"
        }
    }
    
    func setup(_ account: AccountReference) {
        accountNameLabel.text = account.name
        accountNameLabel.textColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
        institutionImage.image = account.institution?.image
    }
}
