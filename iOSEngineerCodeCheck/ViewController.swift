//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    var githubRepositories: [[String: Any]]=[]
    
    var urlSessionTask: URLSessionTask?
    var touchedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SearchBar.text = "GitHubのリポジトリを検索できるよー"
        SearchBar.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        urlSessionTask?.cancel()
    }
    
    func executeSessionTask(_ searchWord : String) {
        let repositoryURL = "https://api.github.com/search/repositories?q=\(searchWord)"
        guard let url = URL(string : repositoryURL) else {return}
        urlSessionTask  = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {return}
            guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {return}
            guard let items = obj["items"] as? [[String: Any]] else {return}
            self?.githubRepositories = items
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        // タスク(githubからデータ読み込み)開始
        urlSessionTask?.resume()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchWord = searchBar.text else {return}
        
        if searchWord.count != 0 {
            // urlに含められない形式のsearchWordやリポジトリからのデータの受け取りに失敗した時は何もしない
            executeSessionTask(searchWord)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail" {
            guard let detailViewController = segue.destination as? ViewController2 else {return}
            detailViewController.viewController1 = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubRepositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let repositoryData = githubRepositories[indexPath.row]
        cell.textLabel?.text = repositoryData["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repositoryData["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        touchedCellIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
