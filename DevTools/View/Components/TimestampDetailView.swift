//
//  TimeStampDetailView.swift
//  DevTools
//
//  Created by Karen on 2024/11/22.
//

import SwiftUI

enum TimeUnit: String, CaseIterable {
    case seconds = "Second"
    case milliseconds = "Millisecond"
}

struct TimestampDetailView: View {
    @State private var currentTimestamp = ""
    @State private var timestampToBeConverted = ""
    @State private var timestampConvertResult = ""
    
    @State private var timeStringToBeConverted = ""
    @State private var timeStringConvertResult = ""
    
    @State private var timerRunning = true
    @State private var timer: Timer?
    
    @State private var selectedUnit: TimeUnit = .seconds
    
    init() {
        timer = buildTimer()
        
        _timestampToBeConverted = State(initialValue: "\(Int(Date().timeIntervalSince1970))")
        _timestampConvertResult = State(initialValue: formattedDate(from: timestampToBeConverted, timeUnit: .seconds) ?? "")
        
        _timeStringToBeConverted = State(initialValue: timestampConvertResult)
        _timeStringConvertResult = State(initialValue: timestampToBeConverted)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            currentTimestampView
            Spacer().frame(height: 100)
            convertTimestampView
            Spacer().frame(height: 100)
            convertTimeStringView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
        .onAppear {
            if timerRunning {
                startTimer()
            }
        }
    }
    
    // MARK: UI
    private var currentTimestampView: some View {
        HStack {
            Text("Current Timestamp:")
                .font(.title)
            Spacer()
            NonEditableSelectableTextField(text: $currentTimestamp, isEditable: false)
            Spacer()
            Toggle("", isOn: $timerRunning)
                .toggleStyle(SwitchToggleStyle())
                .onChange(of: timerRunning) { _, newValue in
                    if newValue {
                        startTimer()
                    } else {
                        pauseTimer()
                    }
                }
            Text(timerRunning ? "Start" : "Pause")
        }
    }
    private var convertTimestampView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Unix Timestamp:")
                    .font(.title)
                NonEditableSelectableTextField(text: $timestampToBeConverted, isEditable: true)
                    .frame(width: 220)
                timeUnitPickerView
                
                Spacer()
                
                Button(action: {
                    timestampConvertResult = formattedDate(from: timestampToBeConverted, timeUnit: selectedUnit) ?? "ERROR"
                }, label: {
                    Text("convert")
                })
            }

            HStack {
                Text("Result:")
                    .font(.title)
                NonEditableSelectableTextField(text: $timestampConvertResult, isEditable: false)
                    .frame(width: 220)
            }
        }
    }
    
    private var convertTimeStringView: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("Time:")
                    .font(.title)
                NonEditableSelectableTextField(text: $timeStringToBeConverted, isEditable: true)
                    .frame(width: 220)
                timeUnitPickerView
                
                Spacer()
                
                Button(action: {
                    timeStringConvertResult = stringToTimestamp(dateString: timeStringToBeConverted, timeUnit: selectedUnit) ?? "ERROR"
                }, label: {
                    Text("convert")
                })
            }
            
            HStack {
                Text("Result:")
                    .font(.title)
                NonEditableSelectableTextField(text: $timeStringConvertResult, isEditable: true)
                    .frame(width: 220)
            }
        }
    }
    private var timeUnitPickerView: some View {
        Picker("", selection: $selectedUnit) {
            ForEach(TimeUnit.allCases, id: \.self) { unit in
                Text(unit.rawValue.capitalized)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .fixedSize()
    }
    
    // MARK: Actions
    private func startTimer() {
        timer?.invalidate()
        timer = buildTimer()
    }
    private func pauseTimer() {
        timer?.invalidate()
    }
    /// convert timestamp to string
    private func formattedDate(from timestampString: String, timeUnit: TimeUnit) -> String? {
        guard let timestamp = Double(timestampString) else {
            return nil
        }
        
        let timestampInSeconds = timeUnit == .milliseconds ? timestamp / 1000 : timestamp
        let date = Date(timeIntervalSince1970: timestampInSeconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    /// convert string to timestamp
    func stringToTimestamp(dateString: String, timeUnit: TimeUnit) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        if let date = dateFormatter.date(from: dateString) {
            let timestamp = date.timeIntervalSince1970
            return String(Int(timeUnit == .milliseconds ? timestamp * 1000 : timestamp))
        } else {
            return nil
        }
    }
    
    // MARK: Getter
    func buildTimer() -> Timer {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let timestamp = Int(Date().timeIntervalSince1970)
            currentTimestamp = "\(timestamp)"
        }
    }
}

#Preview {
    TimestampDetailView()
}
