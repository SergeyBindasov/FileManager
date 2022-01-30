//
//  ViewController.swift
//  FileManager
//
//  Created by Sergey on 28.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let fileManager = FileManager.default
    
    var content: [URL] = []
    var newFolder: URL?
    
    @IBOutlet weak var fileTableview: UITableView!
    
    @IBAction func createFolder(_ sender: UIBarButtonItem) {
        
        var folder = UITextField()
        
        let alert = UIAlertController(title: "Создать новую папку", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { action in
            guard let text = folder.text else { return }
            self.newFolder = self.loadContent().appendingPathComponent(text)
            guard let folder = self.newFolder else { return }
            do {
                try self.fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: [:])
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self.loadContent()
            }
        }
            alert.addTextField { textField in
                textField.placeholder = "Новая папка"
                folder = textField
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileTableview.delegate = self
        fileTableview.dataSource = self
        loadContent()
    }
}
// MARK:  Class Methods
extension ViewController {
    func loadContent() -> URL {
        let documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        content = try! fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: [])
        fileTableview.reloadData()
        return documentsURL
    }
}

// MARK:  TableView Methods
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(fileManager.displayName(atPath: content[indexPath.row].path))
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let folderName = content[indexPath.row].path
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = fileManager.displayName(atPath: folderName)
        return cell
    }
    
}
