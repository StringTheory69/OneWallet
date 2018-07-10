//  Created by jacob small on 6/23/18.
//  Copyright © 2018 jacob small. All rights reserved.

//  #1 TODO: should I use Object Mapper?

import Foundation
import ObjectMapper

// Models

struct SidePanelViewData {
    var accounts: [AccountReference]?
}

class AccountsReferences: Mappable {
    
    var accountsReferences: [AccountReference]?
    
    init?(accountsReferences: [AccountReference]) {
        self.accountsReferences = accountsReferences
        print("did it")
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        accountsReferences <- map["accountsReferences"]
    }
}

class AccountReference: Mappable {
    
    var id: String?
    var name: String?
    var institution: Institution?
    
    init?(id: String, name: String, institution: String) {
        self.id = id
        self.name = name
        self.institution = Institution(rawValue: institution)!
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        institution <- map["institution"]
    }
}

// #11 TODO: Create enum with pngs for all institutions offered - will needed to be updated as institutions are added 

enum Institution: String {
    case BofA = "BofA"
    case WF = "WF"
    case Citi = "Citi"
    case Chase = "Chase"
    
    var image: UIImage {
        switch self {
        case .BofA: return UIImage(named: "BofA.png")!
        case .WF: return UIImage(named: "BofA.png")!
        case .Citi: return UIImage(named: "Citi.png")!
        case .Chase: return UIImage(named: "BofA.png")!
        }
    }
}

