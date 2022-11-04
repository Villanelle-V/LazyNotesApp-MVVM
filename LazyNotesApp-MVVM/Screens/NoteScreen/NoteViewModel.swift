//
//  NoteModelView.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-03.
//

import Foundation
import CoreData


class NoteModelView: NoteModelViewType {
    var dbManager: CoreDataHelperProtocol = CoreDataHelper()
    //var currentNote: String?
    var currentNote: Observable<String?> = Observable(nil)
    
    func addText(text: String) {
        //currentNote = text
        currentNote.value = text
    }
    
    func addNote() {
//        guard let note = currentNote else { return }
//        dbManager.addNote(text: note)
        guard let note = currentNote.value else { return }
        dbManager.addNote(text: note)
        saveNote()
    }
    
    func saveNote() {
        dbManager.saveNote()
    }
}
