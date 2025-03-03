//
//  BoardItem.swift
//  Connect4
//
//  Created by Kshrugal Jangalapalli on 3/1/25.
//

import UIKit

enum Tile{
    case Red, Yellow, Empty
}

struct BoardItem {
    
    var indexPath: IndexPath!
    var tile: Tile!
    
    func yellowTile() -> Bool {
        return tile == Tile.Yellow
    }
    
    func redTile() -> Bool {
        return tile == Tile.Red
    }
    
    func emptyTile() -> Bool {
        return tile == Tile.Empty
    }
    
    func tileColor() -> UIColor {
        if redTile() {
            return .red
        } else if yellowTile() {
            return .yellow
        }
        return .white
    }
}
