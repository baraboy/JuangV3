//
//  BitMask.swift
//  SemarangGame
//
//  Created by Patrick Samuel Owen Saritua Sinaga on 09/11/23.
//

import Foundation

enum bitMask: UInt32 {
    case hero = 0b1
    case ground = 0b10
    case box = 0b100
    case duri = 0b1000
    case keyCategory = 0b10000
    case boxSenjata = 0b100000
    case tuas = 0b1000000  //Mini games
    case trapSituation = 0b10000000
    case buttonObstacle = 0b100000000
    case gedung = 0b1000000000
    case jepangEnemy = 0b10000000000
    case boxdorong = 0b100000000000
    case tuas2 = 0b1000000000000
}

enum HeroState {
    case normal
    case transformed
    case transformed1
    case transformed2
}
