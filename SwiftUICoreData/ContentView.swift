//
//  ContentView.swift
//  SwiftUICoreData
//
//  Created by Luthfi Abdul Azis on 04/03/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var peopleData = PeopleViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: People.entity(), sortDescriptors: [], animation: .spring())
    var peoples: FetchedResults<People>
    
    @State var isShowDialog: Bool = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(peoples) { item in
                    Item(item: item, peopleData: peopleData, isShowDialog: $isShowDialog)
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        peopleData.deleteData(context: viewContext, people: peoples[index])
                    }
                })
            }
            .listStyle(PlainListStyle())
            .navigationTitle("People")
            .navigationBarItems(trailing: Button(action: {
                peopleData.refreshForm()
                isShowDialog.toggle()
            }, label: {
                Image(systemName: "plus.circle")
                    .imageScale(.large)
            }))
            .sheet(isPresented: $isShowDialog, content: {
                withAnimation {
                    DialogView(peopleData: peopleData, isShowDialog: $isShowDialog)
                }
            })
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct Item: View {
    
    @State var item: People
    @ObservedObject var peopleData: PeopleViewModel
    @Binding var isShowDialog: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            
            HStack {
                Text(item.gender + " \(item.age) years old")
                    .font(.subheadline)
            }
        }.contextMenu {
            Button(action: {
                peopleData.updateData(people: item)
                isShowDialog.toggle()
            }, label: {
                Text("Edit People")
            })
        }
        
    }
}
