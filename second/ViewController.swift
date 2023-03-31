//
//  ViewController.swift
//  second
//
//  Created by FurkiSelos on 29.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var tableView: UITableView!
    let defaults = UserDefaults.standard

    
    var note:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApp()
        let savedArray = defaults.object(forKey: "SavedNotes") as? [String] ?? [String]()
        note = savedArray
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        if let text = textField.text {
                note.append(text)
        }
        defaults.set(note, forKey: "SavedNotes")
        tableView.reloadData()
        textField.text = ""
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return note.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableOneViewCell
        cell.label.text = note[indexPath.row]
        cell.label.numberOfLines = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableOneViewCell
        cell.label?.text = note[indexPath.row] // notes, notlarınızın listesi olsun
        cell.label?.numberOfLines = 0
        cell.label?.lineBreakMode = .byWordWrapping
        cell.label?.sizeToFit()
        let height = cell.label?.frame.height ?? 0.0
        return height + 20.0    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}

extension ViewController: UITextViewDelegate{
    
    func setupApp() {
        tableView.dataSource = self
        tableView.delegate = self
   }
    
   
}


