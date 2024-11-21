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
    @State private var timerRunning = true
    @State private var timer: Timer?
    
    @State private var selectedUnit: TimeUnit = .seconds
    
    init() {
        timer = buildTimer()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            getCurrentTimestamp
            Spacer()
            getConvertTimestamp
        }
        .padding()
        .onAppear {
            if timerRunning {
                startTimer()
            }
        }
    }
    
    // MARK: UI
    private var getCurrentTimestamp: some View {
        HStack {
            Text("Current Timestamp:")
                .font(.title)
            Spacer()
            NonEditableSelectableTextField(text: currentTimestamp, isEditable: false)
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
    private var getConvertTimestamp: some View {
        HStack {
            Text("Timestamp:")
                .font(.title)
            Spacer()
            NonEditableSelectableTextField(text: "\(Int(Date().timeIntervalSince1970))", isEditable: true)
            Spacer()
            Picker("", selection: $selectedUnit) {
                ForEach(TimeUnit.allCases, id: \.self) { unit in
                    Text(unit.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
            Spacer()
            Button(action: {
                onConvertClick()
            }, label: {
                Text("convert")
            })
            NonEditableSelectableTextField(text: formattedDate(from: "\(Int(Date().timeIntervalSince1970))"), isEditable: true)
        }
    }
    
    // MARK: Actions
    private func startTimer() {
        timer?.invalidate()
        timer = buildTimer()
    }
    private func pauseTimer() {
        timer?.invalidate()
    }
    private func onConvertClick() {
        print("onConvertClick")
    }
    private func formattedDate(from timestampString: String) -> String {
        guard let timestamp = Double(timestampString) else {
            return "invalid timestamp"
        }
        
        let timestampInSeconds = timestamp >= 1e12 ? timestamp / 1000 : timestamp
        let date = Date(timeIntervalSince1970: timestampInSeconds)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
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
