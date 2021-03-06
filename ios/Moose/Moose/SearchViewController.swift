//
//  SearchViewController.swift
//  Moose
//
//  Created by Sven Titgemeyer on 17.10.19.
//  Copyright © 2019 Moose. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchViewControllerDelegate: class {
    func didSelect(model: SearchModel)
}

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
    
    // MARK: Properties
    
    @IBOutlet var tableView: UITableView!
    weak var delegate: SearchViewControllerDelegate?
    let useDiffable = false

    var results: [SearchModel] = [] {
        didSet {
            if useDiffable {
                var snapshot = dataSource.snapshot()
                snapshot.deleteAllItems()
                if snapshot.sectionIdentifiers.count == 0 {
                    snapshot.appendSections(["one"])
                }
                snapshot.appendItems(results)
                dataSource.apply(snapshot)
            } else {
                tableView.reloadData()
            }
        }
    }
    
    lazy var dataSource: UITableViewDiffableDataSource<String, SearchModel> = {
        let ds: UITableViewDiffableDataSource<String, SearchModel> = UITableViewDiffableDataSource(tableView: self.tableView!) { (tv, indexPath, model) -> UITableViewCell? in
            let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = model.descr
            return cell
        }
        
        return ds
    }()
    
    // MARK: View Lifecycle
    
    init() {
        super.init(nibName: "SearchViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = SearchProvider.shared
        if useDiffable {
            self.tableView.dataSource = dataSource
        } else {
            self.tableView.dataSource = self
        }
        self.tableView.delegate = self
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView()
    }

    // MARK: Interactions

    @IBAction func refreshTableView(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let results = Array(Set(SearchProvider.shared.results(query: text)))
        self.results = results
    }
    
    func dismiss() {
        self.results = []
    }

}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let search = results[indexPath.row]
        delegate?.didSelect(model: search)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = results[indexPath.row].descr
        return cell
    }
}

class SearchBackgroundView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        if view is UITextField || view.superview is UITableViewCell || view is UITableViewCell {
            return view
        } else {
            return nil
        }
    }
}
