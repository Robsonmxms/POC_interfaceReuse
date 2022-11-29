//
//  TextField.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyViewCode()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TextFieldTableViewCell: ViewCodeConfiguration {
    func buildHierarchy() {}

    func setupConstraints() {}

    func configureViews() {}

}
