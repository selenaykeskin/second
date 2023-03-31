//
//  DetailVC.swift
//  second
//
//  Created by FurkiSelos on 31.03.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    var viewModel: DetailVM = DetailVM()
    
    var detailLabelText: String = ""
    @IBOutlet weak var detalilText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        detalilText.text =  detailLabelText
    }
    

}
