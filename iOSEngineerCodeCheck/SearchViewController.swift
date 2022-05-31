//
//  searchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 渡辺大智 on 2022/05/29.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    var githubData = GithubData()
    
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
        githubData.urlSessionTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let searchWord = searchBar.text else {return}
        
        if searchWord.count != 0 {
            // urlに含められない形式のsearchWordやリポジトリからのデータの受け取りに失敗した時は何もしない
            githubData.createURLSessionTask(searchWord)
            if githubData.urlSessionTask != nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                githubData.urlSessionTask?.resume()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? DetailViewController  else {return}
            detailVC.searchVC = self
            detailVC.githubData = githubData
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        githubData.touchedCellIndex = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
}
