//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
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
    
    var searchVC: SearchViewController?
    var githubData: GithubData?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        githubData?.setTouchedRepository()
        guard let repository = githubData?.touchedGithubRepository else {return}
        programLangageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        starsLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(repository["watchers_count"] as? Int ?? 0) watchers" //APIの使用が変更されwatchers_countはstargazers_countの数値が出力されるとのこと
        forksLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        isuuesLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        titleLabel.text = repository["full_name"] as? String
        getImage()
    }
    
    func getImage() {
        guard let owner = githubData?.repository["owner"] as? [String: Any] else {return}
        guard let imgURL = owner["avatar_url"] as? String else {return}
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { [weak self] (data, res, err) in
            guard let data = data else {return}
            guard let img = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self?.imageView.image = img
            }
        }.resume()
        /*if githubData.urlSessionTask != nil {
            
        }*/
        DispatchQueue.main.async {
            self.imageView.image = img
        }
        githubData.urlSessionTask?.resume()
    }

}
