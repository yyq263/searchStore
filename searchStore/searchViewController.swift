//
//  ViewController.swift
//  searchStore
//
//  Created by Yiqin Yao on 19/10/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import UIKit

class searchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var landscapeViewController: LandscapeViewController?
  
    let search = Search()
    
    
    func showLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
        // 1
        guard landscapeViewController == nil else { return }
        // 2
        landscapeViewController = storyboard!.instantiateViewController(
            withIdentifier: "LandscapeViewController")
            as? LandscapeViewController
        if let controller = landscapeViewController {
            controller.search = search
            // 3
            controller.view.frame = view.bounds
            controller.view.alpha = 0
            // 4
            view.addSubview(controller.view) //add the landscape controller’s view as a subview
            addChildViewController(controller)//Then tell the SearchViewController that the LandscapeViewController is now managing that part of the screen
            coordinator.animate(alongsideTransition: { _ in
                controller.view.alpha = 1
                self.searchBar.resignFirstResponder()
                if self.presentedViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
                }, completion: { _ in
                    controller.didMove(toParentViewController: self) //Tell the new view controller that it now has a parent view controller
            })
        }
        
    }
    
    func hideLandscape(with coordinator:
        UIViewControllerTransitionCoordinator) {
        if let controller = landscapeViewController {
            controller.willMove(toParentViewController: nil) //view controller that it is leaving the view controller hierarchy (it no longer has a parent)
            coordinator.animate(alongsideTransition: { _ in
                controller.view.alpha = 0
                }, completion: { _ in
                    controller.view.removeFromSuperview()
                    controller.removeFromParentViewController()
                    self.landscapeViewController = nil
            })
        }
    }
    
    
    private struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    
    func showNetworkError() {
        let alert = UIAlertController(
            title: "Whoops...",
            message:
            "There was an error reading from the iTunes Store. Please try again.",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        //print("Segment changed: \(sender.selectedSegmentIndex)")
        performSearch()
    }
   
    
    func performSearch() {
        if let category = Search.Category(
            rawValue: segmentedControl.selectedSegmentIndex) {
            search.performSearch(for: searchBar.text!,
                                 category: category) { success in
            if !success {
                self.showNetworkError()
            }
                self.tableView.reloadData()
            }
            searchBar.resignFirstResponder()
        }
    }
    
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            fatalError("Should never get here")
        case .loading:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TableViewCellIdentifiers.loadingCell,
                for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        case .noResults:
            return tableView.dequeueReusableCell(
                withIdentifier: TableViewCellIdentifiers.nothingFoundCell,
                for: indexPath)
        case .results(let list):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TableViewCellIdentifiers.searchResultCell,
                for: indexPath) as! SearchResultCell
            let searchResult = list[indexPath.row]
            cell.configure(for: searchResult)
            return cell
        }
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        if search.isLoading {
//            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.loadingCell, for: indexPath)
//            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
//            spinner.startAnimating()
//            return cell
//        } else if search.searchResults.count == 0 {
//            return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFoundCell, for: indexPath)
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
//            
//            let searchResult = search.searchResults[indexPath.row]
//            cell.configure(for: searchResult)
//            return cell
//        }
//        
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch search.state {
        case .notSearchedYet:
            return 0
        case .loading:
            return 1
        case .noResults:
            return 1
        case .results(let list):
            return list.count
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowDetail" {
//            let detailViewController = segue.destination as! DetailedViewController
//            let indexPath = sender as! IndexPath
//            let searchResult = search.searchResults[indexPath.row]
//            detailViewController.searchResult = searchResult
//        }
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if case .results(let list) = search.state {
                let detailViewController = segue.destination as! DetailedViewController
                let indexPath = sender as! IndexPath
                let searchResult = list[indexPath.row]
                detailViewController.searchResult = searchResult
            }
        }
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowDetail", sender:  indexPath)
    }// tap on a row and it will become selected and stays selected, cancel it with animation
    
    func tableView(_ tableView: UITableView,
                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch search.state {
        case .notSearchedYet, .loading, .noResults:
            return nil
        case .results:
            return indexPath
        }
    }
//    func tableView(_ tableView: UITableView,
//                   willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        if search.isLoading || search.searchResults.count == 0 {
//            return nil
//        } else {
//            return indexPath
//        }
//    }// if count == 0, cell shows (not found), and it cannot be selected. However, if press this cell for a while, it will still be selected. Set selection to none in the Attributes inspector.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.becomeFirstResponder()
        tableView.rowHeight = 80
        tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0) // 20-points for the status bar and 44-points for the search bar, table view cell is 64-points below to top.
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier:
            TableViewCellIdentifiers.loadingCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator:UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        switch newCollection.verticalSizeClass {
        case .compact:
            showLandscape(with: coordinator)
        case .regular, .unspecified:
            hideLandscape(with: coordinator)
        }
    }
    


}



















