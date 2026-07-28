# 🛡️ CyberSafe Pune

### Cyber Security & Cyber Crime Awareness System

A community service project aimed at spreading cyber security awareness among school students through an interactive web-based platform and real-life awareness sessions.

🔗 **Live Demo:** [https://chiprikarpranit.github.io/cybersafe-pune/](https://chiprikarpranit.github.io/cybersafe-pune/)

---

## 📖 About the Project

In today's digital era, students are constantly exposed to online risks like OTP scams, phishing attacks, digital arrest frauds, and social media exploitation. **CyberSafe Pune** addresses this by combining:

- A real awareness session conducted at **Prerna School, Ambegaon Pathar, Pune**
- A complete **web-based awareness system** built with HTML & CSS
- A **PostgreSQL database** with tables, queries, triggers, and stored procedures

The project successfully educated **50+ students** of 8th, 9th, and 10th standard with an average session rating of **4.5 / 5**.

---

## ✨ Features

- 🏠 **Home Page** — Overview, stats, and feature highlights
- 📚 **Awareness Page** — Session details, topics covered, and photo gallery
- 🎬 **Videos Page** — OTP scam and digital arrest awareness videos
- 🧠 **Interactive Quiz** — 5-question cyber security quiz with HTML validation
- 📝 **Feedback Form** — Star rating, validated input form (no JavaScript)
- 📊 **Dashboard** — Output report screen with stats, activity table, and survey graphs
- 🔍 **Resources Page** — Links to check email/password leaks and report cyber crime
- 🔒 **Protect & Scam Pages** — Device protection tips and scam awareness
- 👥 **About Page** — Project team and guide information

---

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| **HTML5** | Page structure |
| **CSS3** | Styling and responsive design |
| **PostgreSQL** | Database management |
| **pgAdmin 4** | Database GUI and ERD tool |
| **Google Sheets** | Survey data and charts |

---

## 📂 Project Structure

```
cybersafe-pune/
├── index.html          # Home page
├── awareness.html       # Awareness session page
├── videos.html          # Awareness videos page
├── quiz.html            # Interactive quiz
├── feedback.html         # Feedback form with validation
├── dashboard.html        # Output report dashboard
├── resources.html        # Safety resources & links
├── protect.html          # Device protection tips
├── scam.html             # Scam awareness tips
├── about.html            # Project team info
├── style.css             # Stylesheet for all pages
├── database.sql          # PostgreSQL database file
├── img1.jpg - img5.jpg    # Session photos
├── otp.mp4                # OTP scam awareness video
└── video.mp4              # Digital arrest awareness video
```

---

## 🗄️ Database

The project uses **PostgreSQL** with the following structure:

- **5 Tables** — `students`, `feedback`, `quiz_results`, `session_log`, `feedback_audit`
- **Foreign Keys** — Proper relationships between all tables
- **2 Triggers** — Auto-logging and rating validation
- **5 Stored Procedures** — For feedback, ratings, and session summary
- **Sample Data** — Pre-loaded for testing

Run the database file using:
```sql
\i 'database.sql'
```

---

## 👥 Project Team

| Name | Roll No. |
|---|---|
| Madhvi Kune | 51375 |
| Ashish Survase | 51311 |
| Chetan Gatane | 51368 |
| Pranit Chiprikar | 51274 |

**Project Guide:** Prof. Supriya Sagar

---

## 🎓 Submitted For

Community Service Project — SYBCA
Department of Computer Application
Sinhgad College of Science, Pune
Savitribai Phule Pune University

---

## 📜 Resources Used

- [Have I Been Pwned](https://haveibeenpwned.com/) — Check email/password leaks
- [National Cyber Crime Reporting Portal](https://cybercrime.gov.in/) — Report cyber crimes

---

© 2026 CyberSafe Pune Project
