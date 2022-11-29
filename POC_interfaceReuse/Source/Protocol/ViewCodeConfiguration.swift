//
//  ViewCodeConfiguration.swift
//  POC_interfaceReuse
//
//  Created by Robson Lima Lopes on 24/11/22.
//

import Foundation

protocol ViewCodeConfiguration {
    func buildHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewCodeConfiguration {
    func applyViewCode() {
        buildHierarchy()
        setupConstraints()
        configureViews()
    }
}
