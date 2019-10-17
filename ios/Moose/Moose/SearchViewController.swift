//
//  SearchViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit
import CoreLocation

struct SearchModel: Codable, Hashable, Equatable {
    var name: String?
    var title: String?
    var location: CLLocationCoordinate2D? {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    private var lat: CLLocationDegrees
    private var lon: CLLocationDegrees
    
    var descr: String? {
        return title ?? name
    }
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case title = "Title"
        case lat = "Latitude"
        case lon = "Longitude"
    }
}

class SearchProvider: NSObject {
    
    static let shared = SearchProvider()
    private let searchResults: [SearchModel]
    
    func results(query: String) -> [SearchModel] {
        return searchResults.filter { (model) -> Bool in
            guard let descr = model.descr else {
                return false
            }
            return descr.contains(query)
        }
    }
    
    override init() {
        let url = Bundle.main.url(forResource: "streets.Aachen", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let searchResults = try! JSONDecoder().decode([SearchModel].self, from: data).prefix(100)
        self.searchResults = Array(searchResults)
    }
}

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tableView: UITableView!
    lazy var dataSource: UITableViewDiffableDataSource<String, SearchModel> = {
        let ds: UITableViewDiffableDataSource<String, SearchModel> = UITableViewDiffableDataSource(tableView: self.tableView!) { (tv, indexPath, model) -> UITableViewCell? in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = model.descr
            return cell
        }
        
        return ds
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = dataSource
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
        
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
        snapshot.deleteAllItems()
        if snapshot.sectionIdentifiers.count == 0 {
            snapshot.appendSections(["one"])
        }
        let results = Array(Set(SearchProvider.shared.results(query: text)))
        snapshot.appendItems(results)
        dataSource.apply(snapshot)
    }
}

class SearchBackgroundView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        if view is UITextField || view is UITableViewCell {
            return view
        } else {
            return nil
        }
    }
}
