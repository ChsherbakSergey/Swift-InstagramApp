//
//  FormTableViewCell.swift
//  InstagramApp
//
//  Created by Sergey on 11/30/20.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"
    
    private var model: EditProfileFormModel?
    
    public weak var delegate : FormTableViewCellDelegate?

    //Views that will be displayed on this cell
    private let formLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let textfield : UITextField = {
        let textfield = UITextField()
        textfield.returnKeyType = .done
        return textfield
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        selectionStyle = .none
        //Adding subview
        contentView.addSubview(formLabel)
        contentView.addSubview(textfield)
        //sets delegate to the textfield
        setDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //frame of the formLabel
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width / 3, height: contentView.height)
        //frame of the textfield
        textfield.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - 10 - formLabel.width, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        textfield.placeholder = nil
        textfield.text = nil
    }
    
    ///Sets delegates
    private func setDelegates() {
        textfield.delegate = self
    }
    
    ///Configures the cell
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        textfield.placeholder = model.placeholder
        textfield.text = model.value
    }

}

//MARK: - UITextFieldDelegate Realization

extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textfield.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textfield.resignFirstResponder()
        return true
    }
    
}
