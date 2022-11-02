//
//  SortNotesAlertController.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-09.
//

import Foundation
import UIKit

protocol AddSortActionProtocol {
    func addSortAction(model: NotesListViewModelType)
}

extension AddSortActionProtocol where Self: NotesListViewController {
    func addSortAction(model: NotesListViewModelType) {
        let alert = UIAlertController(title: nil, message: "Sort notes", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "By name", style: .default, handler:{ (UIAlertAction) in
            model.sortNotes(by: .byName)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "By date", style: .default, handler: { (UIAlertAction) in
            model.sortNotes(by: .byDate)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
