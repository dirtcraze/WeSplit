import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    
    @FocusState private var isFocusedKeyboard: Bool
        
    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipValue = checkAmount * Double(tipPercentage) / 100
        let returnedValue = (checkAmount + tipValue) / peopleCount
        
        return returnedValue
            
    }
    
    private var totalAmount: Double {
        let tipValue = checkAmount * Double(tipPercentage) / 100
        let returnedValue = (checkAmount + tipValue)
        
        return returnedValue
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Entry amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).keyboardType(.decimalPad).focused($isFocusedKeyboard)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<13) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Total amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if isFocusedKeyboard {
                    Button("Done") {
                        isFocusedKeyboard = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
