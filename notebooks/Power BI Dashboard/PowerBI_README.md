# Spotify Music Analytics — Power BI Dashboard

## 📌 Project Overview

This project presents an interactive **Power BI dashboard** built to analyze approximately **90,000 Spotify tracks** based on popularity, genres, artists, explicit content, and audio characteristics.

The dashboard is designed to transform raw Spotify track data into meaningful visual insights and allow users to interactively explore patterns across different musical attributes.

The project focuses on:

- Track and artist popularity
- Genre-level popularity
- Energy and popularity relationships
- Explicit vs non-explicit content
- Audio characteristics across genres
- Track duration distribution
- Tempo distribution
- Acousticness and instrumentalness

---

## 🎯 Objectives

The main objectives of this project are to:

1. Analyze the most popular Spotify genres.
2. Identify highly popular artists and collaborations.
3. Examine the relationship between energy and popularity.
4. Understand the proportion of explicit and non-explicit tracks.
5. Compare audio characteristics across popular genres.
6. Analyze the distribution of track duration.
7. Analyze the distribution of track tempo.
8. Explore the relationship between acousticness and instrumentalness.
9. Build an interactive dashboard that allows users to investigate the data dynamically.

---

## 📊 Dataset

The dataset contains approximately **90K Spotify tracks** with information related to:

### Track Information
- `track_id`
- `track_name`
- `track_artist`
- `track_genre`
- `duration_ms`
- `explicit`

### Audio Features
- `danceability`
- `energy`
- `key`
- `loudness`
- `mode`
- `speechiness`
- `acousticness`
- `instrumentalness`
- `liveness`
- `valence`
- `tempo`

### Popularity
- `track_popularity`

The dataset was cleaned and transformed before being used for dashboard development.

---

## 🛠️ Tools & Technologies

- **Power BI Desktop**
- **Power Query**
- **DAX**
- Data Visualization
- Data Modeling
- Interactive Dashboard Design

---

# 📑 Dashboard Structure

The dashboard consists of **two analytical pages**.

---

## 📄 Page 1 — Spotify Music Analytics

### KPI Cards

The overview section contains five key metrics:

- **Total Tracks**
- **Average Popularity**
- **Average Energy**
- **Average Danceability**
- **Average Valence**

These provide a quick summary of the selected dataset or filtered context.

### Visualizations

#### 1. Top 10 Genres by Average Popularity

A horizontal bar chart showing the ten genres with the highest average track popularity.

**Key observation:**
- Pop-film has the highest average popularity at approximately **59**.
- K-pop follows at approximately **57**.
- Chill and sad are also among the higher-performing genres.

#### 2. Energy vs Popularity by Genre

A scatter plot comparing:

- Average Energy
- Average Popularity

A trendline is included to identify the overall relationship between the two variables.

**Key observation:**
- There is a **weak positive relationship** between energy and popularity.
- Higher-energy tracks tend to show slightly higher popularity on average.
- However, the large spread of observations indicates that energy alone does not strongly determine popularity.

#### 3. Top 10 Artists & Collaborations by Average Popularity

A bar chart highlighting artists and artist collaborations with the highest average popularity.

The dataset contains collaboration combinations such as:

`Artist A;Artist B`

which are treated as individual artist-name values.

**Key observation:**
- Several artists/collaborations have average popularity above **90**.
- The highest-ranked entries include collaborations and individual artists with exceptionally high popularity.

#### 4. Explicit vs Non-Explicit Tracks

A donut chart showing the proportion of explicit and non-explicit tracks.

**Key observation:**
- Approximately **91.4%** of tracks are non-explicit.
- Approximately **8.6%** of tracks are explicit.

This indicates that explicit tracks represent a relatively small proportion of the dataset.

---

## 📄 Page 2 — Spotify Audio Analytics

The second page focuses on the musical characteristics and distributions within the dataset.

### 1. Audio Characteristics of Top 10 Popular Genres

A grouped horizontal bar chart comparing:

- Average Danceability
- Average Energy
- Average Valence

across the top 10 genres.

**Key observations:**

- **Sad** has the highest average danceability at approximately **0.69**.
- **Grunge** has the highest average energy at approximately **0.80**.
- **Sertanejo** has relatively high energy and valence.
- **K-pop** shows a relatively balanced audio profile.
- Grunge has high energy but comparatively low valence, demonstrating that high energy does not necessarily imply a positive emotional character.

### 2. Track Duration Distribution

A histogram showing the distribution of track durations.

**Key observations:**

- Most tracks are concentrated around approximately **2–4 minutes**.
- The distribution is **right-skewed**.
- The number of tracks decreases substantially as duration increases.
- Very long tracks are relatively uncommon.

### 3. Acousticness vs Instrumentalness

A scatter plot comparing:

- Average Acousticness
- Average Instrumentalness

across genres.

**Key observations:**

- Most observations have relatively low instrumentalness.
- Acousticness varies considerably across tracks.
- There is no strong visible relationship between acousticness and instrumentalness.
- A smaller number of tracks show substantially higher instrumentalness.

### 4. Track Tempo Distribution

A histogram showing the distribution of track tempos.

**Key observations:**

- Most tracks fall broadly within the **80–160 BPM** range.
- The distribution is concentrated around approximately **120–130 BPM**.
- Extremely slow and extremely fast tracks are relatively uncommon.

---

# 🔄 Interactivity

The dashboard supports interactive filtering and cross-highlighting.

Selecting an item in one visual dynamically affects the other visuals on the page.

For example:

- Selecting an artist updates the KPI cards and related visuals.
- Selecting a genre filters the associated audio characteristics.
- Selecting a data point in the scatter plot allows individual observations to be investigated.
- The dashboard can therefore be used for both high-level analysis and detailed exploration.

---

# 🧮 DAX & Calculations

DAX was used to create the key analytical measures required for the dashboard.

Examples include:

- Total track count
- Average popularity
- Average energy
- Average danceability
- Average valence
- Explicit/non-explicit track counts
- Top-N analysis

Conditional logic was also used to transform categorical fields such as the explicit-status indicator into dashboard-friendly categories.

---

# 🔍 Key Insights

### Popularity

- Pop-film has the highest average popularity among the displayed genres.
- K-pop and chill also demonstrate relatively high average popularity.
- Popularity varies substantially across genres and artists.

### Energy & Popularity

- Energy and popularity show a **weak positive relationship**.
- This suggests that energy may contribute to popularity, but it is not sufficient to explain popularity on its own.

### Explicit Content

- The dataset is strongly dominated by non-explicit tracks.
- Only around **8.6%** of tracks are explicit.

### Track Duration

- Most Spotify tracks in the dataset are relatively short.
- The largest concentration occurs around **2–4 minutes**.
- Track frequency declines as duration increases.

### Tempo

- Tracks are largely concentrated around moderate tempos.
- The distribution peaks around approximately **120–130 BPM**.

### Audio Characteristics

- Different genres exhibit noticeably different combinations of danceability, energy and valence.
- High energy does not necessarily correspond to high valence.
- Most tracks have low instrumentalness, suggesting that vocal tracks dominate the dataset.

---

# 💡 Overall Conclusion

The Spotify Music Analytics dashboard demonstrates that music popularity is influenced by multiple characteristics rather than a single audio feature.

While certain genres and artists consistently achieve higher popularity, the relationship between individual audio features such as energy and popularity is relatively weak. The dataset is predominantly non-explicit, while most tracks fall within a relatively narrow range of duration and tempo.

The genre-level analysis also demonstrates that different genres have distinct audio profiles, particularly in terms of danceability, energy and valence.

Overall, the dashboard provides an interactive way to explore **what makes Spotify tracks popular and how musical characteristics vary across genres**.

---

# 📈 Skills Demonstrated

- Power BI Dashboard Development
- Power Query
- DAX
- Data Cleaning & Transformation
- Data Modeling
- KPI Development
- Top-N Analysis
- Conditional Columns
- Interactive Visualizations
- Cross-filtering
- Scatter Plot Analysis
- Histogram Analysis
- Data Storytelling
- Dashboard UI/UX Design
