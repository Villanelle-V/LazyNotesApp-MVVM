//
//  ViewModel.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-09-29.
//

import Foundation


class NotesListViewModel: NotesListViewModelType {
    var sortType: SortingNotesType = .byDate
    var notes: [Note] = []
    var dbManager: CoreDataHelperProtocol = CoreDataHelper()
    var isSearching = false
    var filteredData: [Note] = []
    
    func fetchNote() {
        notes = dbManager.fetchNotes()
        filteredData = notes
    }
    
    func deleteNote(indexPath: IndexPath) {
        dbManager.deleteNote(note: notes[indexPath.row])
        fetchNote()
    }
    
    func getNotes() -> [Note] {
        if isSearching {
            return filteredData
        }
        return notes
    }
    
    func searchNote(searchText: String) {
        filteredData = []

        if searchText == "" {
            filteredData = notes
        } else {
            for note in notes {
                if note.content.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(note)
                }
            }
        }
    }
}

//// MARK: - AddNoteDelegate
//extension NotesListViewModel: AddNoteDBDelegate {
//    func addNote() {
//        fetchNote()
//    }
//}

// MARK: - Sorting notes
extension NotesListViewModel {
    func sortNotes(by type: SortingNotesType) {
        switch type {
        case .byName:
            let sort = notes.sorted { $0.content < $1.content }
            self.notes = sort
        case .byDate:
            let sort = notes.sorted { $0.date < $1.date }
            self.notes = sort
        }
    }
}
