//
//  ViewController.swift
//  TODOTask
//
//  Created by Mac on 26/10/1940 Saka.
//  Copyright © 1940 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,UISearchControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    var todo = [Todo]()
    var arrdata = [String:String]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        searchBarSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        dataModal()
    }
    
    func dataModal()
    {
        todo = DatabaseHelper.shareInstant.getTodoData()
        DispatchQueue.main.async {
        self.tableView.reloadData()
        }
    }
    
    private func searchBarSetup()
    {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barStyle = .blackTranslucent
        
        searchController.searchBar.placeholder = "Search By Title"
    }
    
    @IBAction func btnAddTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as! AddToDoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
}
extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete", handler: { (action, indexPath) in
            //Action delete
            let todos = indexPath.row
            var data = DatabaseHelper.shareInstant.deleteData(index: todos)
            self.todo.remove(at: todos)
            tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        })
        
        let editAction = UITableViewRowAction(style: .normal, title: "Update", handler: { (action, indexPath) in
            //Action edit
            let todos = self.todo[indexPath.row]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as! AddToDoViewController
            let  data = ["title":todos.title!,"note":todos.note!,"date":todos.date!]
            vc.dict = data
            vc.isEdit = true
            vc.index = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
        })
        editAction.backgroundColor = UIColor.orange
        deleteAction.backgroundColor = UIColor.red
        return [ deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TodoListTableViewCell
        cell.cellView.layer.cornerRadius = 10
        
        cell.cellView.layer.shadowOffset = CGSize.zero
        cell.cellView.layer.shadowColor = UIColor.black.cgColor
        cell.cellView.layer.shadowOpacity = 5
        cell.cellView.clipsToBounds = true
        
        let todos = todo[indexPath.row]
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.lblTitle.text = todos.title
        cell.lblNote.text = todos.note
        cell.lblDate.text = todos.date
        return cell
    }
}
extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard  var searhText = searchController.searchBar.text else {
            return
        }
        if searhText == ""
        {
            self.dataModal()
        }else{
            searhText = searhText.uppercased()
            todo = todo.filter({ (todo) -> Bool in
                (todo.title?.lowercased().contains(searhText.lowercased()))!
            })
            tableView.reloadData()
        }
    }
    
}
