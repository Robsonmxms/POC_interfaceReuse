//
//  TableView.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 29/11/22.
//

import UIKit

class TableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        applyViewCode()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TableView: ViewCodeConfiguration {
    func buildHierarchy() {}

    func setupConstraints() {}

    func configureViews() {
        self.register(ImageTableViewCell.self, forCellReuseIdentifier: "imageCell")
        self.backgroundColor = .darkGray
    }
}
