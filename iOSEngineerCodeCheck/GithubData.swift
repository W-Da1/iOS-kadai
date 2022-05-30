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
    var touchedGitHubRepository: [String: Any]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubRepositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repositoryData = githubRepositories[indexPath.row]
        cell.textLabel?.text = repositoryData["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repositoryData["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    // URLSessionTaskを作成する
    func createURLSessionTask(_ searchWord : String) {
        let repositoryURL = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let url = URL(string : repositoryURL) else {return}
        urlSessionTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {return}
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
            guard let items = obj["items"] as? [[String: Any]] else {return}
            self?.githubRepositories = items
        }
    }
    
    func setTouchedRepository() {
        guard let index = touchedCellIndex else {return}
        if githubRepositories.count != 0 {
            touchedGitHubRepository = githubRepositories[index] //範囲外指定対処あった方がいいか
        }
    }

}
