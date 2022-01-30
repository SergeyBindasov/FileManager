//
//  FolderViewController.swift
//  FileManager
//
//  Created by Sergey on 30.01.2022.
//

import UIKit

class FolderViewController: UIViewController {
    
    let fileManager = FileManager.default
    
    var subfolderContent: [URL] = []
    var newItem: URL?
    
    @IBOutlet weak var subfolderTableView: UITableView!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        print("pic")
    }
    
    @IBAction func addSubfolder(_ sender: UIBarButtonItem) {
        print("folder")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        subfolderTableView.delegate = self
        subfolderTableView.dataSource = self
    }
}

extension FolderViewController: UITableViewDelegate {
    
}

extension FolderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subfolderContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "folderCell")
        
        return cell
    }
}


