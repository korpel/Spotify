//
//  ViewController.swift
//  Spotify
//
//  Created by Antonis Vozikis on 31/05/2017.
//  Copyright © 2017 Antonis Vozikis. All rights reserved.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {
    
    var searchUrl = "https://api.spotify.com/v1/search?q=Eminem&type=track"
    
    var names = [String]()
    
    typealias JSONStandard = [String : AnyObject]
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer BQC3A5x-PGY2vqSN9p-FS_nL1wMPdBJq57aZLUXjCTxVoTIIyGzfF4agdIkp6fDflNh33fHCSjt4tSKhqcmGec1eSeYHDEEDB7iNv_BVjWzugTbSXUzfh0bLaIUv6LyK1OMi-41ZoWw",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamo(url: searchUrl)
    }
    
    
    func callAlamo(url : String) {
        
        Alamofire.request(url, headers: headers).responseJSON(completionHandler: {
            response in
            
            self.parseData(JSONData: response.data!)
            
        })
        
    }
    
    func parseData(JSONData : Data){
        
        do {
            let readableJson = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJson["tracks"] as? JSONStandard {
                if let items = tracks["items"] {
                    
                    for i in 0..<items.count {
                        let item = items[i] as! JSONStandard
                        let name = item["name"] as! String
                        names.append(name)
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
        catch {
            print(error)
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = names[indexPath.row]
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

