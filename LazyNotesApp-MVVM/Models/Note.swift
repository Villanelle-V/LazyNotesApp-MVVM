//
//  Note.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-09-29.
//

import Foundation

struct Note {
    let date: Date
    let time: Date
    let content: String
    
    init(with note: NoteMO) {
        self.date = note.date
        self.time = note.time
        self.content = note.content
    }
}
