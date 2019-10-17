//
//  SearchViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit

struct SearchModel: Codable {
    var name: String
    var title: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
    }
}

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    lazy var dataSource: UITableViewDiffableDataSource<String, String> = {
        let ds: UITableViewDiffableDataSource<String, String> = UITableViewDiffableDataSource(tableView: self.tableView!) { (tv, indexPath, text) -> UITableViewCell? in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = text
            return cell
        }
        
        return ds
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func refreshTableView(_ sender: UITextField) {
        guard let text = sender.text else { return }
        var snapshot = dataSource.snapshot()
        if snapshot.sectionIdentifiers.count == 0 {
            snapshot.appendSections(["one"])
        }
        snapshot.appendItems([text])
        dataSource.apply(snapshot)
    }
    
}
