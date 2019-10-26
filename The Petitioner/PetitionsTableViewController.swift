//
//  PetitionsTableViewController.swift
//  The Petitioner
//
//  Created by Student on 10/24/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class PetitionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Petitions"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filter))
        NotificationCenter.default.addObserver(self, selector: #selector(dataFetched), name: NSNotification.Name(rawValue:"Petitions Fetched"), object: nil)
    }
    
    @objc func dataFetched(notification:Notification){
        tableView.reloadData()
    }
    
    @objc func filter() {
        PetitionBank.shared.fetchPetitions("&title=President%20Trump")
    }
    
    @objc func refresh() {
        PetitionBank.shared.fetchPetitions()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PetitionBank.shared.numPetitions
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "petitioncell", for: indexPath)

        let petition = PetitionBank.shared[indexPath.row]
        
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = "\(petition.signatureCount)/\(petition.signatureThreshold)"

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petitionVC = storyboard!.instantiateViewController(withIdentifier: "petitioninfo") as! PetitionInfoViewController
        
        petitionVC.petition = PetitionBank.shared[indexPath.row]
        
        self.navigationController!.pushViewController(petitionVC, animated: true)
    }
}
