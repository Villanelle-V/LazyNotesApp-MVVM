//
//  NotesListViewModelType.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-11-04.
//

import Foundation


enum SortingNotesType {
    case byName
    case byDate
}

protocol NotesListViewModelType {
    var sortType: SortingNotesType { get }
    var notes: [Note] { get set }
    var dbManager: CoreDataHelperProtocol { get set }
    var isSearching: Bool { get set }
    
    func fetchNote()
    func deleteNote(indexPath: IndexPath)
    func getNotes() -> [Note]
    func searchNote(searchText: String)
    func sortNotes(by: SortingNotesType)
}
