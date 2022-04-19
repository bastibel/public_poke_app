//
//  CreatureDetail.swift
//  Catch 'em All
//
//  Created by Basti Belmonte on 4/19/22.
//

import Foundation

class CreatureDetail {
    
    private struct Returned: Codable {
        var weight: Double
        var height: Double
        var sprites: Sprites
    }
    private struct Sprites: Codable {
        var front_default: String
    }
    var height = 0.0
    var weight = 0.0
    var imageURL = ""
    var urlString = ""
    
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
                self.height = returned.height
                self.weight = returned.weight
                self.imageURL = returned.sprites.front_default
            } catch {
            print("JSON Error")
            }
            completed()
        }
        task.resume()
    }
}

