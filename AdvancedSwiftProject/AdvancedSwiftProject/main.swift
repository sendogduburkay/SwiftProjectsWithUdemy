//
//  main.swift
//  AdvancedSwiftProject
//
//  Created by Muhammed Burkay Şendoğdu on 17.08.2022.
//

import Foundation

let classJames = MusicianClass(name: "James", age: 34, insturement: "Guitar")

//let structJames = MusicianStruct(name: "James", age: 50, instrument: "Guitar")
var structJames = MusicianStruct(name: "James", age: 50, instrument: "Guitar")

classJames.age = 51

structJames.age = 51 /* Structta propertylerin değerlerini değiştirebilmek için Structan oluşturduğun structJames'i var ile tanımlamak zorundasın. Let ile tanımlarsan hiçbir şartta value değişikliği yapmaz. */



// REFERENCE VS VALUE

//let copyOfClassJames = classJames
//var copyOfStructJames = structJames
//
//print(copyOfClassJames.age)
//print(copyOfStructJames.age)
//
//
//copyOfClassJames.age = 52
//copyOfStructJames.age = 52
//
//print(copyOfClassJames.age)
//print(copyOfStructJames.age)
//
//
//print(classJames.age)
//print(structJames.age)

classJames.happyBirthday()
print(classJames.age)
structJames.happyBirthday()
print(structJames.age)




// TUPLES - Birden fazla değişkeni, veriyi tutuyor.

let myTuple = (1,3)
print(myTuple.0)

var myTuple2 = (1,2,3,4,5)
print(myTuple2.1)
myTuple2.2 = 5

var newTuple = (name: "Burkay", lastname: "Şendoğdu")
print(newTuple.name)


