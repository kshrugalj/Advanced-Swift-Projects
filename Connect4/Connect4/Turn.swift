//
//  Turn.swift
//  Connect4
//
//  Created by Kshrugal Jangalapalli on 3/1/25.
//

import Foundation
import UIKit

enum Turn {
    case Red, Yellow
}

var currentTurn = Turn.Yellow

func yellowTurn() -> Bool {
    return currentTurn == Turn.Yellow
}

func redTurn() -> Bool {
    return currentTurn == Turn.Red
}

func currentTurnTile() -> Tile {
    return yellowTurn() ? Tile.Yellow : Tile.Red
}

func currentTurnColor() -> UIColor {
    return yellowTurn() ? .systemYellow : .red
}

func currentTurnVictoryMessage() -> String {
    return yellowTurn() ? "Yellow Wins!" : "Red Wins!"
}

func toggleTurn(_ turnImage: UIImageView) {
    if yellowTurn() {
        currentTurn = Turn.Red
        turnImage.tintColor = .red
    } else {
        currentTurn = Turn.Yellow
        turnImage.tintColor = .systemYellow
    }
}
