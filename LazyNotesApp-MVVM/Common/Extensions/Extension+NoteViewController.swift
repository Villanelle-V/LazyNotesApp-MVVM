//
//  Extension+Controller.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-13.
//

import Foundation
import UIKit

enum NoteScreenState {
    case create
    case edit
    case review
}

protocol NotesViewControllerStateProtocol {
    var viewModel: NoteModelViewType { get }
    var state: NoteScreenState { get }
    
    func configureNavigationBar()
    func loadingContent(with text: String)
}

extension NotesViewControllerStateProtocol where Self: NoteViewController {
    func configureNavigationBar() {
        if state == .review {
            let share = UIBarButtonItem(barButtonSystemItem: .action,
                                        target: self,
                                        action: #selector(shareButtonTapped(sender:)))
            self.navigationItem.rightBarButtonItem = share
        } else {
            let save = UIBarButtonItem(barButtonSystemItem: .save,
                                       target: self,
                                       action: #selector(saveButtonTapped(sender:)))
            self.navigationItem.rightBarButtonItem = save
        }
    }
}

// MARK: - TextView Delegate
extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard state == .review else { return }
        state = .edit
        configureNavigationBar()
    }
    func textViewDidChange(_ textView: UITextView) {
        viewModel.addText(text: textView.text)
    }
    
    func loadingContent(with text: String) {
        if state == .create {
            //viewModel.currentNote = ""
            viewModel.currentNote.value = ""
        } else {
            //viewModel.currentNote = text
            viewModel.currentNote.value = text
        }
    }
}
