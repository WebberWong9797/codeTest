//
//  ViewController.swift
//  appleAlbum
//
//  Created by Webber Wong on 10/3/2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ApiService.postAlbumDict(url: "https://itunes.apple.com/search?term=jack+johnson&entity=album") { (dict, error) in
            guard error == nil else{
                return
            }
            print(dict["results"][0]["collectionType"])
        }
    }
    
    func loadAlbumDict(){
        
    }


}

