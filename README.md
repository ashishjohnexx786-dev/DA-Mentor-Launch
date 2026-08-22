# DA Mentor OS v4 — Final Master

Offline-first mentor + progress tracker synchronized to the locked **Data Analyst Zero-to-Job-Ready 2026** curriculum.

## Final curriculum
- 12 phases
- 120 lesson units
- 12 mastery gates
- Planning workload: roughly 372–516 focused hours
- Calendar estimate is separate from mastery; 120 units are **not** 120 days

## Curriculum source of truth
The app mirrors:
`135_Final_Master_Study_Tracker_2026.xlsx`

Each unit shows the exact master-package Lesson Book and Practice path.

## Upgrade from v3
v3 used a 7-stage / 112-day plan. v4 intentionally starts curriculum completion clean so old day checkboxes cannot create false mastery in the rebuilt curriculum. Settings, notes and focus history can be migrated; the old `daMentorOSv3` localStorage key is not deleted.

## Data
Progress is stored locally under:
`daMentorOSv4`

Use Backup/Restore regularly.

## Deployment
GitHub Pages serves the static PWA. The service worker cache is `da-mentor-os-v4`.
