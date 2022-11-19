//
//  Functions.swift
//  MyApp
//
//  Created by Trung on 01/11/2022.
//

import Foundation

var monsters = Monsters()
var colorNames = ColorNames()

func loadAllMonster(completed: @escaping (Monsters) -> Void) {
    DispatchQueue.global().async {
        guard let data = Bundle.dataContent(ofFile: "pokedex", withType: "json") else {
            completed([])
            return
        }
        let list = try? JSONDecoder().decode(Monsters.self, from: data)
        completed(list ?? [])
    }

}

func loadAllColorName(completed: @escaping (ColorNames) -> Void) {
    DispatchQueue.global().async {
        guard let data = Bundle.dataContent(ofFile: "colors", withType: "json") else {
            completed([])
            return
        }
        let list = try? JSONDecoder().decode(ColorNames.self, from: data)
        completed(list ?? [])
    }

}

func randomColorName() -> ColorName {
    colorNames.shuffled().first!
}
