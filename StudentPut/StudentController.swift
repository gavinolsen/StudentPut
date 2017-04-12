//
//  StudentController.swift
//  StudentPut
//
//  Created by Gavin Olsen on 4/12/17.
//  Copyright © 2017 Gavin Olsen. All rights reserved.
//

import Foundation

class StudentController {
    
    static let baseURL = URL(string: "https://students-e8889.firebaseio.com/students")
    
    
    
    static let getterEnd = baseURL?.appendingPathExtension("json")
    
    //fetch method
    
    static func fetchStudents(completion: @escaping ([Student]) -> Void) {
        
        
        guard let getter = getterEnd else { return }
        NetworkController.performRequest(url: getter, httpMethod: .get) { (data, error) in
            
            guard let data = data else { completion([]); return }
            guard let studentDict = (try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])) as? [String:[String:Any]] else { completion([]); return }
            
            //[$0: [.0: .1]]
            let students = studentDict.flatMap { Student(dict: $0.1) }
            completion(students)
            
        }
        
        
    }
    
    //post method

    static func post(student name: String, completion: ((_ success: Bool) -> Void)? = nil) {
        
        let student = Student(name: name)
        guard let url = baseURL?.appendingPathComponent(name).appendingPathExtension("json") else {return}
        
        NetworkController.performRequest(url: url, httpMethod: .put, body: student.jsonData) { (data, error) in
            
            var success = false
            defer { completion?(success) }
            
            guard let data = data, let responseDataString = String(data: data, encoding: .utf8) else { return }
            
        
            if error != nil {
                print("error : \(String(describing: error))")
            } else if responseDataString.contains("error") {
                print("error: \(responseDataString)")
            } else {
                print("success: \(responseDataString)")
                success = true
            }
        }
        
    }
    
}












