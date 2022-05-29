//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 渡辺大智 on 2022/05/29.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var programLangageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var isuuesLabel: UILabel!
    
    var searchViewController: SearchViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
  
        guard let index = searchViewController.touchedCellIndex else {return}
        let gitRepository = searchViewController.githubRepositories[index]
        
        programLangageLabel.text = "Written in \(gitRepository["language"] as? String ?? "")"
        starsLabel.text = "\(gitRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(gitRepository["watchers_count"] as? Int ?? 0) watchers" //APIの使用が変更されwatchers_countはstargazers_countの数値が出力されるとのこと
        forksLabel.text = "\(gitRepository["forks_count"] as? Int ?? 0) forks"
        isuuesLabel.text = "\(gitRepository["open_issues_count"] as? Int ?? 0) open issues"
        getImage(gitRepository)
    }
    
    func getImage(_ gitRepository : [String: Any]){
        
        titleLabel.text = gitRepository["full_name"] as? String
        
        guard let owner = gitRepository["owner"] as? [String: Any] else {return}
        guard let imgURL = owner["avatar_url"] as? String else {return}
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { [weak self] (data, res, err) in
            guard let data = data else {return}
            guard let img = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self?.imageView.image = img
            }
        }.resume()
    }
}
