//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var programLangageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var isuuesLabel: UILabel!
    
    var viewController1: ViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gitRepository = viewController1.githubRepository[viewController1.touchedCellIndex]
        
        programLangageLabel.text = "Written in \(gitRepository["language"] as? String ?? "")"
        starsLabel.text = "\(gitRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(gitRepository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(gitRepository["forks_count"] as? Int ?? 0) forks"
        isuuesLabel.text = "\(gitRepository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
        
    }
    
    func getImage(){
        
        let gitRepository = viewController1.githubRepository[viewController1.touchedCellIndex]
        
        titleLabel.text = gitRepository["full_name"] as? String
        
        guard let owner = gitRepository["owner"] as? [String: Any] else {return}
        guard let imgURL = owner["avatar_url"] as? String else {return}
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
            guard let data = data else {return}
            guard let img = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self.imageView.image = img
            }
        }.resume()
    }
}
