# Course 1 Data Analyst 2026 — Mentor edition Astra 2026

Live course: https://ashishjohnexx786-dev.github.io/DA-Mentor-Launch/

A complete beginner route: M00–M11, 120 controlled lessons and 12 assessment gates. Start with **How to study**, then continue from the first unfinished lesson. The Mentor is the teaching interface: mapped videos/sources, full written lesson text, practice links, progress checks and protected review are kept together.

## Study flow

Watch the assigned instructor/official source when mapped, read the complete written lesson in the Mentor, follow the worked example, do the practical task yourself, save your attempt, then use protected review only after the attempt. At each gate follow A → Review A → different fresh B → Review B. The Mentor records your study decisions; it does not automatically grade your answers.

AMOLED and light themes, adjustable reading size, course roadmap, protected reviews, browser-local progress, export/restore and a detailed How-to-study guide are included. There is no forced timer. Videos require access to their original provider. Export progress before clearing browser data or changing devices; phone and PC do not synchronize automatically.

Download the complete current repository from Settings. Read the repository verification/QA markers for native-runtime limits. No generated video lessons are included.

## Repository layout

- index.html, styles.css, app.js: current DE-2026-style Mentor interface.
- curriculum.json and data/: the current 120-lesson course route and complete lesson text layer.
- assets/: canonical learner, practice, revision, assessment and supporting course files.
- sw.js and manifest.webmanifest: scoped offline caching and app metadata.
- CURRENT_RELEASE.txt / verification files: release and audit markers when present.

The repository contains one current Course 1 Mentor route. Earlier Mentor versions remain recoverable in Git history. Local progress uses the edition-specific key `course1-da-2026-study-astra-v2`.

The September 21 cache reset uses a repository-scoped service worker. It removes the known legacy Four-Course Mentor caches without touching the protected Standalone DE Mentor 2026 repository or its cache.
