//
//  ViewController.swift
//  Journey_Test
//
//  Created by Indivar Raina on 05/08/22.
//
import UIKit

class PostsViewController: UIViewController {
    public var postsViewModel = PostsViewModel()
    private var dataSource: [PostsModel]?
    private var filteredDataSource: [PostsModel]?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Posts"
        tableView.register(UINib(nibName: AppConstants.CellIdentifiers.kPostCell, bundle: nil),
                           forCellReuseIdentifier: AppConstants.CellIdentifiers.kPostCell)
        fetchPostsData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func fetchPostsData() {
        postsViewModel.getAPIData(param: [:],
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

extension PostsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.CellIdentifiers.kPostCell, for: indexPath) as? PostCell
        cell?.lblTitle.text = filteredDataSource?[indexPath.row].title
        cell?.lblDesc.text = filteredDataSource?[indexPath.row].body
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommentsViewController") as? CommentsViewController
        let postObj = filteredDataSource?[indexPath.row]
        vc?.postId = postObj?.id
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PostsViewController: UISearchBarDelegate {
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText:String)
        {
            filteredDataSource = dataSource?.filter({ $0.title.localizedCaseInsensitiveContains(searchText)})
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
