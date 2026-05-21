[



https://github.com/user-attachments/assets/906bb5e4-42ed-420b-a18e-dc8db3debf07



# 🛠️ FeedbackFlow — Admin App

A cross-platform mobile application built with **Flutter** and **Firebase** for institution administrators to manage, track, and resolve student complaints and feedback — with real-time updates, analytics dashboard, and pie chart visualization.

---

## 🚀 Features

### 🏫 Admin
- Secure login & set password via **Firebase Authentication**
- View all **new/pending complaints** from students
- Manage and update complaint status in **real time**
- View all **solved/resolved complaints**
- Interactive **pie chart** for complaint analytics & insights
- App settings for personalized experience

### 🌐 General
- Clean and responsive **Material Design 3** UI
- Real-time data sync with **Cloud Firestore**
- Cross-platform: **Android, iOS, Linux & macOS**

---

## 🛠️ Tech Stack

| Layer | Technology |
| Frontend | Flutter (Dart) |
| Auth | Firebase Authentication |
| Database | Cloud Firestore + Firebase Realtime Database |
| Storage | Firebase Storage |
| Charts | pie_chart / fl_chart |

---

## 📁 Project Structure

```)](

# 🛠️ FeedbackFlow — Admin App

A cross-platform mobile application built with **Flutter** and **Firebase** for institution administrators to manage, track, and resolve student complaints and feedback — with real-time updates, analytics dashboard, and pie chart visualization.

---

## 🚀 Features

### 🏫 Admin
- Secure login & set password via **Firebase Authentication**
- View all **new/pending complaints** from students
- Manage and update complaint status in **real time**
- View all **solved/resolved complaints**
- Interactive **pie chart** for complaint analytics & insights
- App settings for personalized experience

### 🌐 General
- Clean and responsive **Material Design 3** UI
- Real-time data sync with **Cloud Firestore**
- Cross-platform: **Android, iOS, Linux & macOS**

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| Auth | Firebase Authentication |
| Database | Cloud Firestore + Firebase Realtime Database |
| Storage | Firebase Storage |
| Charts | pie_chart / fl_chart |


---

## 📁 Project Structure

```
feedback_flow_admin_app/
│
├── android/                                  
│   └── app/
│       └── google-services.json              # Firebase Android config (gitignored)
│
├── ios/                                      
│   └── Runner/
│       └── GoogleService-Info.plist          # Firebase iOS config (gitignored)
│
├── linux/                                    
├── macos/                                    
│
├── lib/
│   ├── main.dart                             # App entry point, Firebase init
│   ├── login_page.dart                       # Admin login screen
│   ├── set_password_page.dart                # Set / reset password screen
│   ├── dashboard.dart                        # Admin dashboard / home
│   ├── NewComplaintPage.dart                 # View new / pending complaints
│   ├── my_complaint_page.dart                # Manage all complaints
│   ├── SolvedComplaintsPage.dart             # View resolved complaints
│   ├── pie_chart_display.dart                # Complaint analytics pie chart
│   └── settings_page.dart                    # App settings screen
│
├── test/
│   └── widget_test.dart                      # Widget tests
│
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── devtools_options.yaml
├── pubspec.yaml                              # Dependencies & assets
└── pubspec.lock
```

---

## 🔗 App Screens

| Screen | Description |
|---|---|
| `login_page.dart` | Admin login with email & password |
| `set_password_page.dart` | Set or reset admin password |
| `dashboard.dart` | Main admin home screen |
| `NewComplaintPage.dart` | View all new & pending complaints |
| `my_complaint_page.dart` | Manage and update complaint status |
| `SolvedComplaintsPage.dart` | View all resolved complaints |
| `pie_chart_display.dart` | Visual analytics of complaint data |
| `settings_page.dart` | App settings & preferences |

---

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`^3.5.4`)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A Firebase project with **Authentication**, **Firestore**, **Realtime Database**, **Storage**, and **FCM** enabled

### 1. Clone the Repository

```bash
git clone https://github.com/Praful2604/feedback_flow_admin_app.git
cd feedback_flow_admin_app
```

### 2. Flutter Setup

```bash
flutter pub get
flutter run
```

### 3. Firebase Setup

1. Create or reuse a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable the following services:
   - **Authentication** (Email/Password)
   - **Cloud Firestore**
   - **Realtime Database**
   - **Firebase Storage**
   - **Cloud Messaging (FCM)**
3. Add config files to your project:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

> **Note:** This admin app shares the same Firebase project as the [FeedbackFlow Student App](https://github.com/Praful2604/feedback_flow_Student_app) so both apps stay in sync in real time.

---

## 🔐 Environment & Secrets

- `android/app/google-services.json` — Android Firebase config (**gitignored, never commit**)
- `ios/Runner/GoogleService-Info.plist` — iOS Firebase config (**gitignored, never commit**)

---

## 📊 Complaint Analytics

The admin app includes a **pie chart dashboard** (`pie_chart_display.dart`) that gives a visual breakdown of:

- Total complaints received
- Pending vs In Progress vs Resolved complaints
- Category-wise complaint distribution

This helps admins quickly identify problem areas and track resolution progress.

---

## 🔔 How It Works

1. Student submits a complaint via the **FeedbackFlow Student App**
2. Complaint is stored in **Cloud Firestore** and appears instantly in `NewComplaintPage`
3. Admin reviews and updates the status → moves to `my_complaint_page`
4. Once resolved → complaint appears in `SolvedComplaintsPage`
5. **FCM push notification** is sent to the student automatically
6. Analytics in `pie_chart_display.dart` update in real time

---

## 🔗 Related Repository

> 👨‍🎓 **Student App** → [feedback_flow_Student_app](https://github.com/Praful2604/feedback_flow_Student_app)

---

## 📦 Key Dependencies

```yaml
firebase_auth                                # Authentication
cloud_firestore                              # Firestore database
firebase_database                            # Realtime database
firebase_storage                             # File storage
intl                                         # Date formatting
url_launcher                                 # External links
```

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

---

## 📄 License

This project is for educational/portfolio purposes.)](https://github.com/user-attachments/assets/YOUR_VIDEO_ASSET_ID_HERE

# 🛠️ FeedbackFlow — Admin App

A cross-platform mobile application built with **Flutter** and **Firebase** for institution administrators to manage, track, and resolve student complaints and feedback — with real-time updates, analytics dashboard, and pie chart visualization.

---

## 🚀 Features

### 🏫 Admin
- Secure login & set password via **Firebase Authentication**
- View all **new/pending complaints** from students
- Manage and update complaint status in **real time**
- View all **solved/resolved complaints**
- Interactive **pie chart** for complaint analytics & insights
- App settings for personalized experience

### 🌐 General
- Clean and responsive **Material Design 3** UI
- Real-time data sync with **Cloud Firestore**
- Cross-platform: **Android, iOS, Linux & macOS**

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Flutter (Dart) |
| State Management | GetX |
| Auth | Firebase Authentication |
| Database | Cloud Firestore + Firebase Realtime Database |
| Storage | Firebase Storage |
| Notifications | Firebase Cloud Messaging (FCM) |
| Charts | pie_chart / fl_chart |
| Local Storage | Shared Preferences |

---

## 📁 Project Structure

```
feedback_flow_admin_app/
│
├── android/                                  
│   └── app/
│       └── google-services.json              # Firebase Android config (gitignored)
│
├── ios/                                      
│   └── Runner/
│       └── GoogleService-Info.plist          # Firebase iOS config (gitignored)
│
├── linux/                                    
├── macos/                                    
│
├── lib/
│   ├── main.dart                             # App entry point, Firebase init
│   ├── login_page.dart                       # Admin login screen
│   ├── set_password_page.dart                # Set / reset password screen
│   ├── dashboard.dart                        # Admin dashboard / home
│   ├── NewComplaintPage.dart                 # View new / pending complaints
│   ├── my_complaint_page.dart                # Manage all complaints
│   ├── SolvedComplaintsPage.dart             # View resolved complaints
│   ├── pie_chart_display.dart                # Complaint analytics pie chart
│   └── settings_page.dart                    # App settings screen
│
├── test/
│   └── widget_test.dart                      # Widget tests
│
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── devtools_options.yaml
├── pubspec.yaml                              # Dependencies & assets
└── pubspec.lock
```

---

## 🔗 App Screens

| Screen | Description |
|---|---|
| `login_page.dart` | Admin login with email & password |
| `set_password_page.dart` | Set or reset admin password |
| `dashboard.dart` | Main admin home screen |
| `NewComplaintPage.dart` | View all new & pending complaints |
| `my_complaint_page.dart` | Manage and update complaint status |
| `SolvedComplaintsPage.dart` | View all resolved complaints |
| `pie_chart_display.dart` | Visual analytics of complaint data |
| `settings_page.dart` | App settings & preferences |

---

## ⚙️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`^3.5.4`)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A Firebase project with **Authentication**, **Firestore**, **Realtime Database**, **Storage**, and **FCM** enabled

### 1. Clone the Repository

```bash
git clone https://github.com/Praful2604/feedback_flow_admin_app.git
cd feedback_flow_admin_app
```

### 2. Flutter Setup

```bash
flutter pub get
flutter run
```

### 3. Firebase Setup

1. Create or reuse a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Enable the following services:
   - **Authentication** (Email/Password)
   - **Cloud Firestore**
   - **Realtime Database**
   - **Firebase Storage**
   - **Cloud Messaging (FCM)**
3. Add config files to your project:
   - `google-services.json` → `android/app/`
   - `GoogleService-Info.plist` → `ios/Runner/`

> **Note:** This admin app shares the same Firebase project as the [FeedbackFlow Student App](https://github.com/Praful2604/feedback_flow_Student_app) so both apps stay in sync in real time.

---

## 🔐 Environment & Secrets

- `android/app/google-services.json` — Android Firebase config (**gitignored, never commit**)
- `ios/Runner/GoogleService-Info.plist` — iOS Firebase config (**gitignored, never commit**)

---

## 📊 Complaint Analytics

The admin app includes a **pie chart dashboard** (`pie_chart_display.dart`) that gives a visual breakdown of:

- Total complaints received
- Pending vs In Progress vs Resolved complaints
- Category-wise complaint distribution

This helps admins quickly identify problem areas and track resolution progress.

---

## 🔔 How It Works

1. Student submits a complaint via the **FeedbackFlow Student App**
2. Complaint is stored in **Cloud Firestore** and appears instantly in `NewComplaintPage`
3. Admin reviews and updates the status → moves to `my_complaint_page`
4. Once resolved → complaint appears in `SolvedComplaintsPage`
5. **FCM push notification** is sent to the student automatically
6. Analytics in `pie_chart_display.dart` update in real time

---

## 🔗 Related Repository

> 👨‍🎓 **Student App** → [feedback_flow_Student_app](https://github.com/Praful2604/feedback_flow_Student_app)

---

## 📦 Key Dependencies

```yaml
firebase_auth                                # Authentication
cloud_firestore                              # Firestore database
firebase_database                            # Realtime database
firebase_storage                             # File storage
firebase_messaging                           # Push notifications (FCM)
get                                          # State management (GetX)
shared_preferences                           # Local storage
intl                                         # Date formatting
url_launcher                                 # External links
```

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

---

## 📄 License

This project is for educational/portfolio purposes.)
