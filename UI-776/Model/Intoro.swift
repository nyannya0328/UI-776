//
//  Intoro.swift
//  UI-776
//
//  Created by nyannyan0328 on 2022/10/21.
//

import SwiftUI

struct Intoro: Identifiable {
    
    var id = UUID().uuidString
    var imageName : String
    var title : String
   
}

var intros: [Intoro] = [
    .init(imageName: "Image 1", title: "Relax"),
    .init(imageName: "Image 2", title: "Care"),
    .init(imageName: "Image 3", title: "Mood Dairy"),
]

let sansBold = "WorkSans-Bold"
let sansSemiBold = "WorkSans-SemiBold"
let sansRegular = "WorkSans-Regular"

let dummyText = "SAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLESAMPLE"
