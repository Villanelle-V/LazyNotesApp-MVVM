//
//  NoteTableViewCell.swift
//  LazyNotesApp-MVVM
//
//  Created by Polina on 2022-09-29.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(note: Note) {
        self.dateLabel.text = note.date.convertDateToString()
        self.timeLabel.text = note.time.convertTimeToString()
        self.contextLabel.text = note.content
    }
}
