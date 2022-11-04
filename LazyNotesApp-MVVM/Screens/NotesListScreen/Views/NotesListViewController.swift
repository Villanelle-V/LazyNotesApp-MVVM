//
//  NotesListViewController.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-09-29.
//

import UIKit

class NotesListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private data
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: NotesListViewModelType
    
    // MARK: - Life cycle
    init() {
        viewModel = NotesListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchNote()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchNote()
        tableView.reloadData()
    }
}

// MARK: - Configure UI
extension NotesListViewController: AddSortActionProtocol {
    func configureUI() {
        configureTableView()
        configureNavigationBar()
        configureSearchBar()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: NoteTableViewCell.className), bundle: nil), forCellReuseIdentifier: String(describing: NoteTableViewCell.className))
        view.addSubview(tableView)
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "Notes"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(addNoteButton(sender:)))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"),
                                         style: .done,
                                         target: self,
                                         action: #selector(sortNotesButton(sender:)))
        
        navigationItem.rightBarButtonItems = [addButton, sortButton]
    }
    
    @objc func addNoteButton(sender: UIBarButtonItem) {
        let vc = NoteViewController(state: .create)
        show(vc, sender: sender)
    }
    
    @objc func sortNotesButton(sender: UIBarButtonItem) {
        addSortAction(model: viewModel)
    }
    
    func configureSearchBar() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
    }
}

// MARK: - Swipe Actions
extension NotesListViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { ( action, view, completion) in
            self.viewModel.deleteNote(indexPath: indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return action
    }
}

// MARK: - Table View delegate
extension NotesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNotes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NoteTableViewCell.className), for: indexPath) as! NoteTableViewCell
        let newNotes = viewModel.getNotes()
        cell.set(note: newNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NoteViewController(state: .review)
        let currentNote = viewModel.notes[indexPath.row].content
        vc.loadingContent(with: currentNote)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Configure UISearch Bar
extension NotesListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchNote(searchText: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.isActive = false
        viewModel.isSearching = false
        viewModel.fetchNote()
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.isSearching = true
    }
}
