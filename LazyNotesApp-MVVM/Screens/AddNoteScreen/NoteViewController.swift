//
//  AddNoteViewController.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-10-03.
//

import UIKit

class NoteViewController: UIViewController, NotesViewControllerStateProtocol {
    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Private data
    var viewModel: NoteModelViewType
    var state: NoteScreenState
    
    // MARK: - Life cycle
    init(state: NoteScreenState) {
        self.viewModel = NoteModelView()
        self.state = state
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTextView()
    }
}

// MARK: - Configure bar button items
extension NoteViewController {
    @objc func saveButtonTapped(sender: UIBarButtonItem) {
        switch state {
        case .create:
            viewModel.addNote()
        case .edit:
            viewModel.saveNote()
        case .review:
            return
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonTapped(sender: UIBarButtonItem) {
        guard let note = viewModel.currentNote else { return }

        let shareController = UIActivityViewController(activityItems: [note], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.textView
        present(shareController, animated: true, completion: nil)
        }
}

extension NoteViewController {
    func configureTextView() {
        let borderGray = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        textView.layer.borderColor = borderGray.cgColor
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5
        textView.delegate = self
        textView.text = viewModel.currentNote
    }
}
