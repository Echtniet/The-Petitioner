//
//  PetitionInfoViewController.swift
//  The Petitioner
//
//  Created by Student on 10/24/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class PetitionInfoViewController: UIViewController {
    var petition:Petition!
    @IBOutlet weak var tfTitle: UILabel!
    @IBOutlet weak var tfBody: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfTitle.text = petition.title
        tfBody.text = petition.body
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
