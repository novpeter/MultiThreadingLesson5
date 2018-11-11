//
//  NewsViewController.swift
//  VKClone
//
//  Created by Петр on 04/10/2018.
//  Copyright © 2018 DreamTeam. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let postIdentifier = "post"
    let estimatedRowHeight = 150
    let detailedPostSequeId = "detailedPost"
    let dataManager = DataManager.sharedInstance
    var posts: [Post]!
    
    /// Add refresher to the table
    lazy var refreshControl: UIRefreshControl = {
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.addSubview(self.refreshControl)
        tableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataManager.obtainData { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    
    
    //MARK: - Configure table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postIdentifier) as! PostTableViewCell
        cell.congigureCell(with: posts[indexPath.row], parentVC: self)
        
        return cell
    }
    
    
    /// Reload table data
    ///
    /// - Parameter refreshControl
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        dataManager.obtainData { (posts) in
            self.posts = posts
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    

    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailedPostSequeId, sender: posts[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailedPostSequeId, let post = sender as? Post {
            
            let destinationController = segue.destination as! DetailedPostViewController
            
            // Передача id для тестирования функции searchPost
            destinationController.postId = post.id
        }
    }
}
