//
//  ViewController.swift
//  Spotify
//
//  Created by Antonis Vozikis on 31/05/2017.
//  Copyright © 2017 Antonis Vozikis. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

struct post {
    let mainImage : UIImage!
    let previewURL : String
    let name : String!
}

var player = AVAudioPlayer()

class TableViewController: UITableViewController {
    
    var searchUrl = "https://api.spotify.com/v1/search?q=wutang&type=track"
    
    var posts = [post]()
    
    typealias JSONStandard = [String : AnyObject]
    
    let headers: HTTPHeaders = [
        "Authorization": "Bearer BQCVbjqf3D7SQwLpZx-V72mjufNhOA--oVP3-joL29G9LxvpkFWRKSH_kXWs7Z3Y_O_CXW2zVDenNQdy95ZqOOtIHKHXLQZckW9LqV5bal6C7wzDnZJBTlWqDkOtdR3qvdFQB7i1FUE"
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
                if let items = tracks["items"] as? [JSONStandard] {
                    
                    for i in 0..<items.count {
                        let item = items[i]
                        let name = item["name"] as! String
                        let previewUrl = item["preview_url"] as! String
                        if let album = item["album"] as? JSONStandard {
                            if let images = album["images"] as? [JSONStandard] {
                                let imageData = images[0]
                                let mainImageUrl = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageUrl!)
                                let mainImage = UIImage(data: mainImageData! as Data)
                                posts.append(post.init(mainImage: mainImage, previewURL: previewUrl, name: name))
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                }
            }
        }
        catch {
            print(error)
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].mainImage
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        
        
        return cell!
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! AudioVC
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
        vc.mainPreviewURL = posts[indexPath!].previewURL
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

