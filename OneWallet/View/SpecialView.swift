//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

// #3 TODO: remove repitition
// Is there are better ways to create these view classes? – Protocols?

// #4 TODO: Add logic for all UI elements
// What is cleanest way to format text – for example 20.01 -> $20.01

import UIKit

// Account Views

class CircleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1
        self.layer.backgroundColor = UIColor.clear.cgColor

    }
    
}

class CircleAccountView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 2, height: 1)
        self.layer.shadowRadius = 3
    }
    
}

// Side Panel Views

class CircleBalanceView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
        
    }
    
}

class SidePanelAccountImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
}

