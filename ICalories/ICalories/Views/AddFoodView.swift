//
//  AddFoodView.swift
//  ICalories
//
//  Created by Kshrugal Reddy Jangalapalli on 2/15/25.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var calories: Double = 0
    
    var body: some View {
            Form {
                Section() {
                    TextField("Food name", text: $name)
                    
                    VStack {
                        Text("Calories: \(Int(calories))")
                        Slider(value: $calories, in: 0...1000, step: 10)
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        Button("Submit") {
                            DataContoller().addFood(
                                name: name,
                                calories: calories,
                                context: managedObjContext)
                            dismiss()
                        }
                        Spacer()
                    }
                }
        }
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}
