//
//  StudentTableViewController.swift
//  StudentPut
//
//  Created by Gavin Olsen on 4/12/17.
//  Copyright © 2017 Gavin Olsen. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func addName(_ sender: Any) {
        
        guard let text = nameTextField.text, !text.isEmpty else { return }
        StudentController.post(student: text) {(success) in
            guard success else {return}
            DispatchQueue.main.async {
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                self.fetchStudents()
            }
        }
    }
    
    //MARK: internal properties
    var students = [Student]() {
    
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    
    }
    
    private func fetchStudents() {
        
        StudentController.fetchStudents { (students) in
            self.students = students
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchStudents()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)

        let student = students[indexPath.row]
        cell.textLabel?.text = student.name

        return cell
    }
  
}
