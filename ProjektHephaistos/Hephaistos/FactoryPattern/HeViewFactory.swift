//
//  HeViewFactory.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 31.05.24.
//

import Foundation

protocol HeViewFactory: HeItemFactory {
    func create(from data: any HeElementData) -> any HeView
}
