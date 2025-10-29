**Learning Journey - iOS App**

A simple and elegant iOS app that helps learners track their daily learning activities, build streaks, and manage rest days “freezes”.
The app includes a personalized onboarding flow, progress tracking, and streak visualization — making learning habits fun and consistent.

**Note:** The app development is still in progress - to achieve full functionality.

** **
**Table of Contents**

- Overview

- Features

- Architecture

- Screens Overview

- Tech Stack

- Installation

- Future Improvements

** **
**Overview**

Learning Journey motivates you to learn every day by providing:
A streak-based tracker for your chosen subject.
A freeze system that allows skipping a day without losing your streak.
A clean, minimal SwiftUI interface.

**In progress:** Persistent data storage, so your progress is saved across launches.

** **
**Features**

🧑‍🎓 Onboarding → Users set their subject and duration (week, month, or year).

🔥 Activity → Tracking	Log learning days and track your streak count.

❄️ Freeze Mode → Temporarily pause your streak without losing progress.

🗓️ Calendar → Integration	Visualize logged and frozen days on a calendar view.

**In progress:** 💾 Persistence → User data is stored locally using UserDefaults and Codable.

** **
**Architecture**


The app follows the MVVM (Model-View-ViewModel) pattern.

- Model        →  LearnerModel.swift, DayModel.swift 

- ViewModel    →  OnboardingViewModel.swift, ActivityViewModel.swift, CalendarModel.swift

- View         →  OnboardingView.swift, ActivityView.swift, CalendarView.swift, CompactCalendarView.swift, MonthlyCalendarView.swift, WeeklyCalendarView.swift, StreakFreeszeView.swift

** **

**📱 Screens Overview**

<img width="290" height="978" alt="Hello Learner" src="https://github.com/user-attachments/assets/c1213395-9f15-4402-94fd-dd2ea977f97e" /> <img width="290" height="978" alt="Activity" src="https://github.com/user-attachments/assets/a5a34b42-2c98-471f-906f-4f5193e678b7" /> <img width="290" height="978" alt="1107" src="https://github.com/user-attachments/assets/a450b789-47bd-4113-b8a5-64353d244c36" /> 


** **

**Tech Stack**

Programmign Language: Swift

Framework: SwiftUI, Foundation, Combine

Architecture: MVVM

**In progress:** Data Storage: UserDefaults + Codable

System Requirements: iOS 17+ / Xcode 15+

** **

**Installation**

1. Clone the repository

2. Open the project in Xcode:

3. open LearningJourney.xcodeproj

4. Build and run on the simulator or a real device

