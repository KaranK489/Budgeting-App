//
//  ContentView.swift
//  Budgeting Swift UI
//
//  Created by Conant Cougars on 12/16/21.
//

import UserNotifications
import SwiftUI

struct ContentView: View {
    
    
    @State private var stepperValue = 10
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthdate = Date()
    @State private var inputMoney = ""
    @State private var totalMoney = 0
    @State private var desc = ""
    @State private var totalBudget = ""
    @State private var progress = 0.0
    @State private var spendings: [String] = []
    @State private var income: [String] = []
    @State private var expenseArr: [Color] = []
    @State private var colorCirc = Color.green
    @State private var expenseColor = Color.red
    @State private var expenseBool = false
    
    
    func incrementStep() {
        totalMoney += Int(inputMoney)!
        expenseColor = Color.red
        expenseBool = true
        progressChange()
    
        }

    func decrementStep() {
        totalMoney -= Int(inputMoney)!
        expenseColor = Color.green
        expenseBool = false
        progressChange()
   
    }
    
    
    init(){
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .badge, .sound]) {success, error in
                if success {
                    print("All set!")
                } else if let error = error {
                    print (error.localizedDescription)
                }
            }
        
    }
      
    
    func progressChange(){
        if (totalBudget != ""){
            var t: Double = Double(totalBudget)!
           progress = Double(totalMoney)/t
        }
        
        if (totalMoney<Int(totalBudget)!){
            colorCirc = Color.green
        } else {
            colorCirc = Color.red
            
            
            let content = UNMutableNotificationContent()
            content.title = "Budgeter"
            content.subtitle = "You have exceeded your weekly budget!"
            content.sound = UNNotificationSound.default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
            
        }
        
     
        if (expenseBool){
            spendings.append(desc + ": $" + inputMoney)
            expenseArr.append(Color.red)

        } else {
            income.append(desc + ": $" + inputMoney)
            expenseArr.append(Color.green)
        }
    }
    
    
    var body: some View {
//        background(Color(red: 0.4627, green: 0.8392, blue: 1.0).ignoresSafeArea())
    
       
        VStack{
           
            Form{
               
                
                
//                Section(header: Text("User Info")) {
//                    TextField("First Name", text: $firstName)
//                    TextField("Last Name", text: $lastName)
//
//                    DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
//
//
//                }
                
                
                Section(header: Text("Budgeting")) {
                    TextField("Weekly Intended Budget", text: $totalBudget)
                    Text("Weekly Budget: $\(String(totalBudget))").font(Font.headline.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Money Spent This Week: $\(String(totalMoney))").font(Font.headline.weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                
                Section(header: Text("")){
                    ZStack{
                        Text("$\(String(totalMoney))/\n$\(String(totalBudget))").multilineTextAlignment(.center)
                        
                        Circle()
                            .stroke(lineWidth: 5)
                            .opacity(0.2)
                            .foregroundColor(colorCirc)
                            .frame(width:200, height:200)
                        
                            .rotationEffect(Angle(degrees: 270))
                        
                        Circle()
                            .trim(from: 0.0, to: progress)
                            .stroke(style: StrokeStyle (lineWidth: 10.0,
                                                        lineCap: .round, lineJoin: .round))
                            .foregroundColor(colorCirc)
                            .frame(width:200, height:200)
                          
                            .rotationEffect(Angle(degrees: 270))
                    }
                }.listRowBackground(Color(UIColor.systemGroupedBackground))
                    .offset(x: 70)
                
                
                
                
                
             
                
//                    ProgressView(value: progress)

                Section(header: Text("Enter Expenses/Income")) {

                    TextField("Amount Spent", text: $inputMoney)

                    TextField("Description", text: $desc)


                    Stepper {
                        Text("Income or Expense")
                    } onIncrement: {
                        incrementStep()

                    } onDecrement: {
                        decrementStep()
                    }
                    .padding(5)
                }


                Section(header: Text("Spendings")) {

                    List {

                     
                        
//                        ForEach(1...5) {i in
//                            Text(spendings[i]).foregroundColor(expenseArr[i])
//                            Text(spendings[i])
//                        }
                       
                        
//                        zip(spendings, expenseArr).forEach {_ in
//                            Text(spendings).foregroundColor(expenseArr)
//                        }
                        
                 

                        ForEach(spendings, id: \.self) { sp in
                            
                            Text(sp).foregroundColor(Color.red)
                         
                        

                        }
//
                    
                    }
                    
                    }
                    
                    Section(header: Text("Income")) {
                        
                    List {

                     
                        
//                        ForEach(1...5) {i in
//                            Text(spendings[i]).foregroundColor(expenseArr[i])
//                            Text(spendings[i])
//                        }
                       
                        
//                        zip(spendings, expenseArr).forEach {_ in
//                            Text(spendings).foregroundColor(expenseArr)
//                        }
                        
                 

                        ForEach(income, id: \.self) { inc in
                            
                            Text(inc).foregroundColor(Color.green)
                         
                        

                        }
//
                    

                    }
                    
                }
                
//
//                if (expenseBoolArr[0] == true){
//                    expenseColor = Color.red
//                } else {
//                    expenseColor = Color.green
//                }
                
                
                
            }
         
        
        

        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(red: 0.4627, green: 0.8392, blue: 1.0).ignoresSafeArea())
            
      
      
    }
    
    
  
   
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
