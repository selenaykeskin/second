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
        setupUI()
        let savedArray = defaults.object(forKey: "SavedNotes") as? [String] ?? [String]()
        note = savedArray
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        if textField.text != "" {
            if let text = textField.text {
                    note.append(text)
            }
            defaults.set(note, forKey: "SavedNotes")
            tableView.reloadData()
            textField.text = ""
        }
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
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        cell.label?.sizeToFit()
        let height = cell.label?.frame.height ?? 0.0
        return height + 20.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            deleteNote(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: "DetailVC", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailVC") as? DetailVC
        var tryText: String = note[indexPath.row]
        if let detailVC = vc {
            detailVC.detailLabelText = tryText
        }

        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}

extension ViewController: UITextViewDelegate{
    
    func setupApp() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelectionDuringEditing = false
   }
    
    func setupUI() {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 16
        tableView.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.view.backgroundColor = .black
        textField.backgroundColor = .clear
        textField.textColor = .white
    }
    
    func deleteNote(index: Int) {
        let alert = UIAlertController(title: "Notu sil", message: "Bu notu silmek istediğinden emin misin?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { [self] action in note.remove(at: index)
            defaults.set(note, forKey: "SavedNotes")
            tableView.reloadData()

        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}


