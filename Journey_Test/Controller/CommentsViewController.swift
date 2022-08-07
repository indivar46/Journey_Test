//
//  CommentsViewController.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//
import UIKit

class CommentsViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var srchBar: UISearchBar!

    //MARK: - Variable Declaration
    public var postId: Int?
    private var dataSource: [CommentsModel]?
    public var commentsViewModel = CommentsViewModel()
    private var filteredDataSource: [CommentsModel]?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comments"
        registerTableCells()
        fetchCommentsData()
    }
    
    //MARK: - Internal Methods
    func registerTableCells() {
        tableView.register(UINib(nibName: AppConstants.CellIdentifiers.kPostCell, bundle: nil), forCellReuseIdentifier: AppConstants.CellIdentifiers.kPostCell)
    }
    
    // MARK: -  This method fetches api response from view model
    func fetchCommentsData() {
        guard let postId = postId else {
            let alert = UIAlertController(title: "Error",
                                          message: "Invalid Post, kindly try later or report admin",
                                          preferredStyle: UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            return
        }
        commentsViewModel.getCommentData(param: [:],postId:postId,
                                         completion: {[weak self] (model, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error",
                                                  message: error?.message,
                                                  preferredStyle: UIAlertController.Style.alert)
                    self?.present(alert, animated: true, completion: nil)
                }
            } else {
                if let model = model {
                    DispatchQueue.main.async {
                        self?.dataSource = model
                        self?.filteredDataSource = model
                        self?.tableView.reloadData()
                    }
                }
            }
        })
    }
}

// MARK: Extension for tableView delegate and datasource methods
extension CommentsViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection
                   section: Int) -> Int {
        return filteredDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifiers.kPostCell,
                                                 for: indexPath) as? PostCell
        cell?.lblTitle.text = filteredDataSource?[indexPath.row].name
        cell?.lblDesc.text = filteredDataSource?[indexPath.row].body
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        srchBar.resignFirstResponder()
    }
}

// MARK: Extension for Search Delegate methods
extension CommentsViewController: UISearchBarDelegate {
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText:String)
    {
        filteredDataSource = dataSource?.filter({ $0.name.localizedCaseInsensitiveContains(searchText)})
        tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredDataSource?.removeAll()
        filteredDataSource = dataSource
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count == 0 {
            filteredDataSource?.removeAll()
            filteredDataSource = dataSource
            tableView.reloadData()
        }
        searchBar.resignFirstResponder()
    }
}
