//
//  GithubData.swift
//  iOSEngineerCodeCheck
//
//  Created by 渡辺大智 on 2022/05/30.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class GithubData {
    
    var githubRepositories: [[String: Any]]=[]
    var urlSessionTask: URLSessionTask?
    var touchedCellIndex: Int?
    var touchedGithubRepository: [String: Any]?
    var gitAccountImage: UIImage?

    // URLSessionTaskを作成する
    func getRepositories(_ searchWord : String) {
        let repositoryURL = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let url = URL(string : repositoryURL) else {return}
        urlSessionTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {return}
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
            guard let items = obj["items"] as? [[String: Any]] else {return}
            self?.githubRepositories = items
        }
    }
    
    // 選択されたリポジトリー情報を読み込む
    func setTouchedRepository() {
        guard let index = touchedCellIndex else {return}
        if githubRepositories.count != 0 {
            touchedGithubRepository = githubRepositories[index]
        }
    }
    
    //アカウントの画像を読み込む
    func getImage() {
        guard let owner = touchedGithubRepository?["owner"] as? [String: Any] else {return}
        guard let imgURL = owner["avatar_url"] as? String else {return}
        URLSession.shared.dataTask(with: URL(string: imgURL)!) { [weak self] (data, res, err) in
            guard let data = data else {return}
            guard let img = UIImage(data: data) else {return}
            DispatchQueue.main.async {
                self?.gitAccountImage = img
            }
        }.resume()
    }
}
