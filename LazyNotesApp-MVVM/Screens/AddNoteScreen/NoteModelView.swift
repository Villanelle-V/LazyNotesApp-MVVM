//
//  NoteModelView.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-03.
//

import Foundation
import CoreData

protocol NoteModelViewType {
    var dbManager: CoreDataHelperProtocol { get }
    var currentNote: String? { get set }
    
    func addText(text: String)
    func addNote()
    func saveNote()
}

class NoteModelView: NoteModelViewType {
    var dbManager: CoreDataHelperProtocol = CoreDataHelper()
    var currentNote: String?
    
    func addText(text: String) {
        currentNote = text
    }
    
    func addNote() {
        guard let note = currentNote else { return}
        dbManager.addNote(text: note)
        saveNote()
    }
    
    func saveNote() {
        dbManager.saveNote()
    }
}
