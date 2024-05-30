//
//  HeView.swift
//  ProjektHephaistos
//
//  Created by Adrian Haubrich on 30.05.24.
//

import SwiftUI

protocol HeView: HeItem, Identifiable {
    var items: [any HeItem] { get set }
}
