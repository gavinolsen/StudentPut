//
//  Student.swift
//  StudentPut
//
//  Created by Gavin Olsen on 4/12/17.
//  Copyright © 2017 Gavin Olsen. All rights reserved.
//

import Foundation

struct Student {

    let name: String

}

//MARK: json

extension Student {
    
    static let namekey = "students"
    
    init?(dict: [String:Any]) {
        
        guard let name = dict[Student.namekey] as? String else {return nil}
        
        self.init(name: name)
    }
    
    
    var dictRep: [String: Any] {
        let dict = [Student.namekey:name]
        return dict
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictRep, options: .prettyPrinted)
    }

}
