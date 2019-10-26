//
//  FriendBook.swift
//  Cheap Shoppers
//
//  Created by Student on 10/19/19.
//  Copyright © 2019 Davelaar,Clinton B. All rights reserved.
//

import Foundation

struct Results:Decodable{
    var results:[Petition]
}

struct Petition:Decodable{
    var id:String
    var type:String
    var title:String
    var body:String
    var signatureThreshold: Int
    var signatureCount:Int
    
    
    struct MyType:Decodable{
        var id:Int
        var name:String
    }
    
    struct Issue:Decodable{
        var id:Int
        var name:String
    }
}

class PetitionBank {
    private var _petitions:[Petition]
    
    var petitions:[Petition]{
        return _petitions
    }
    
    var numPetitions:Int{
        return _petitions.count
    }
    
    private static var _shared:PetitionBank!
    
    static var shared:PetitionBank{
        if _shared == nil{
            _shared = PetitionBank()
        }
        return _shared
    }
    
    subscript(i:Int)-> Petition{
        return _petitions[i]
    }
    
    func fetchPetitions(_ filter:String = ""){
        DispatchQueue.main.async {
            let decoder = JSONDecoder ()
            let petitionURL = "https://api.whitehouse.gov/v1/petitions.json?limit=100\(filter)"
            do {
                if let url = URL (string: petitionURL) {
                    let json = try Data (contentsOf: url)
                    let result = try decoder.decode(Results.self, from: json)
                    self._petitions = result.results
                }
            }
            catch
            {
                print(error)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"Petitions Fetched"), object: nil)
        }
    }
    
    private init(){
        _petitions = []
        fetchPetitions()
    }
    
    
}


