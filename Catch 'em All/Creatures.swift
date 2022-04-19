//
//  Creatures.swift
//  Catch 'em All
//
//  Created by Basti Belmonte on 4/19/22.
//

import Foundation

class Creatures {
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Creature]
    }

    var count = 0
    var urlString = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20"
    var creatureArray: [Creature] = []
    
    func getData(completed: @escaping ()->()) {
        print("We are accessing URL: \(urlString)")
        //create url
        guard let url = URL(string: urlString) else {
            print("Error: could not create URL from \(urlString)")
            return
        }
        //create session
        let session = URLSession.shared
        //get data
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print("Here is what was returned")
                self.creatureArray = self.creatureArray + returned.results
                self.urlString = returned.next ?? ""
                self.count = returned.count
            } catch {
            print("JSON Error")
            }
            completed()
        }
        task.resume()
    }
}
