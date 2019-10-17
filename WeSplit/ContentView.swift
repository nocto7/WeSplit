 //
 //  ContentView.swift
 //  WeSplit
 //
 //  Created by kirsty darbyshire on 09/10/2019.
 //  Copyright © 2019 kirsty darbyshire. All rights reserved.
 //
 
 import SwiftUI
 
 struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 30, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        var sanitisedAmount = checkAmount.replacingOccurrences(of: Locale.current.decimalSeparator ?? ".", with: ".")
        sanitisedAmount = sanitisedAmount.replacingOccurrences(of: Locale.current.groupingSeparator ?? "", with: "")
        let orderAmount = Double(sanitisedAmount) ?? 0
        let tipAmount = tipSelection * orderAmount / 100
        return orderAmount + tipAmount
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 0 + 2.0
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                                
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Grand total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .foregroundColor(tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
            
        }
        
    }
 }
 
 
 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
