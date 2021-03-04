//
//  DialogView.swift
//  SwiftUICoreData
//
//  Created by Luthfi Abdul Azis on 04/03/21.
//

import SwiftUI

struct DialogView: View {
    
    @ObservedObject var peopleData: PeopleViewModel
    @Environment(\.managedObjectContext) var context
    
    @Binding var isShowDialog: Bool
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                    
                    Section(header: Text("Detail")) {
                        
                        TextField("Name", text: $peopleData.name)
                        
                        Picker("Gender", selection: $peopleData.gender) {
                            ForEach(0 ..< peopleData.genders.count) { i in
                                Text(peopleData.genders[i]).tag(i)
                            }
                        }
                        
                        TextField("Age", text: $peopleData.age)
                            .keyboardType(.numberPad)
                            
                    }
                    
                    
                    
                }
                
                Button(action: {
                    peopleData.insertData(context: context)
                    isShowDialog.toggle()
                }, label: {
                    Text(peopleData.isUpdate ? "Update" : "Save")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.size.width - 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Capsule())
                })
                
                .navigationTitle(peopleData.isUpdate ? "Update People" : "Add People")
                .disabled(peopleData.name.isEmpty || peopleData.age.isEmpty)
            }
        }
    }
}

struct DialogView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
