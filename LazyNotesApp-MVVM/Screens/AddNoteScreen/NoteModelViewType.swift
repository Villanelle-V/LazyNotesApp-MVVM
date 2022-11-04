//
//  NoteModelViewType.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-11-04.
//

import Foundation

protocol NoteModelViewType {
    var dbManager: CoreDataHelperProtocol { get }
    var currentNote: String? { get set }
    
    func addText(text: String)
    func addNote()
    func saveNote()
}
