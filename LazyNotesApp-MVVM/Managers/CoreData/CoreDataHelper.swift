//
//  CoreDataHelper.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-03.
//

import UIKit
import CoreData

//protocol AddNoteDBDelegate: AnyObject {
//    func addNote()
//}

protocol CoreDataHelperProtocol {
    func addNote(text: String)
    func saveNote()
    func deleteNote(note: Note)
    func fetchNotes() -> [Note]
}

class CoreDataHelper: CoreDataHelperProtocol {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    let managedContext = persistentContainer.viewContext
    //weak var delegate: AddNoteDBDelegate?
    
    func addNote(text: String) {
        let dbNote = NoteMO(context: managedContext)
        
        dbNote.time = Date()
        dbNote.date = Date()
        dbNote.content = text
        
        saveNote()
    }
    
    func saveNote() {
        print("save note in coredata")
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch let error as NSError {
                managedContext.rollback()
                print("Cloud not save \(error)")
            }
        }
        //delegate?.addNote()
    }
    
    func deleteNote(note: Note) {
        let request: NSFetchRequest<NoteMO> = NoteMO.fetchRequest()
        request.predicate = NSPredicate(format: "content = %@", note.content)
        
        if let results = try? managedContext.fetch(request) {
            results.forEach { managedContext.delete($0) }
        }
        saveNote()
    }
    
    func fetchNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NoteMO>(entityName: "NoteMO")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results.map { return Note(with: $0) }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return [Note]()
    }
}
