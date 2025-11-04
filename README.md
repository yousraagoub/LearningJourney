**Learning Journey - iOS App**

A simple and elegant iOS app with Apple’s new Liquid Glass design that helps learners track their daily learning activities, build streaks, and manage rest days “freezes”.
The app includes a personalized onboarding flow, progress tracking, and streak visualization — making learning habits fun and consistent.

** **
**Table of Contents**

- Overview

- Features

- Architecture

- Screens Overview

- Tech Stack

- Installation

** **
**Overview**

Learning Journey motivates you to learn every day by providing:
A streak-based tracker for your chosen subject.
A freeze system that allows skipping a day without losing your streak.
A clean, minimal SwiftUI interface.
Persistent data storage, so your progress is saved across launches.

** **
**Features**

🧑‍🎓 Onboarding → Users set their subject and duration (week, month, or year).

🔥 Activity → Tracking	Log learning days and track your streak count.

❄️ Freeze Mode → Temporarily pause your streak without losing progress.

🗓️ Calendar → Integration	Visualize logged and frozen days on a calendar view.

💾 Persistence → User data is stored locally using UserDefaults and Codable.

** **
**Architecture**


The app follows the MVVM (Model-View-ViewModel) pattern.

- Model        →  LearnerModel.swift, DayModel.swift 

- ViewModel    →  OnboardingViewModel.swift, ActivityViewModel.swift, CalendarModel.swift

- View         →  OnboardingView.swift, ActivityView.swift, CalendarView.swift, CompactCalendarView.swift, MonthlyCalendarView.swift, WeeklyCalendarView.swift, StreakFreeszeView.swift

** **

**📱 Screens Overview**

<img width="190" height="878" alt="Activity" src="https://github.com/user-attachments/assets/8df8d56c-aabd-44ab-bb18-c764b0da48e7" /> <img width="190" height="878" alt="IMG_0565" src="https://github.com/user-attachments/assets/1f99f6e3-b8e4-4a90-84d7-248517f50753" /> <img width="190" height="878" alt="IMG_0566" src="https://github.com/user-attachments/assets/df0377b0-ba5a-4649-ad1a-e5ff25ada247" />




** **

**Tech Stack**

Programmign Language: Swift

Framework: SwiftUI, Foundation, Combine

Architecture: MVVM

Data Storage: UserDefaults + Codable

System Requirements: iOS 17+ / Xcode 15+

** **

**Installation**

1. Clone the repository

2. Open the project in Xcode:

3. open LearningJourney.xcodeproj

4. Build and run on the simulator or a real device

