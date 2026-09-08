# Power BI Dashboard

## 📊 Spotify Music Analytics Dashboard

Power BI was used as the visualization and reporting layer of the Spotify Analytics project. The dashboard provides an interactive view of track popularity, genre performance, artists, explicit content, and audio characteristics.

The dashboard is organized into two analytical pages:

---

## 📄 Page 1 — Spotify Music Analytics

The first page provides a high-level overview of popularity and content characteristics.

### KPI Cards

- Total Tracks
- Average Popularity
- Average Energy
- Average Danceability
- Average Valence

The KPI cards dynamically respond to selections and filters made within the dashboard.

### Visualizations

#### Top 10 Genres by Average Popularity

Ranks the top genres based on average track popularity.

**Key insight:**
- Pop-film has the highest average popularity among the displayed genres.
- K-pop and chill also rank highly.

#### Energy vs Popularity by Genre

A scatter plot examining the relationship between average energy and average popularity, with a trendline to highlight the overall direction.

**Key insight:**
- Energy and popularity show a weak positive relationship.
- The wide spread of observations indicates that energy alone does not strongly determine popularity.

#### Top 10 Artists & Collaborations by Average Popularity

Highlights the artists and artist combinations with the highest average popularity.

**Key insight:**
- Several artists and collaborations achieve average popularity above 90.
- Collaborations appear prominently among the highest-ranked entries.

#### Explicit vs Non-Explicit Tracks

A donut chart comparing explicit and non-explicit tracks.

**Key insight:**
- Approximately 91.4% of the tracks are non-explicit.
- Approximately 8.6% are explicit.

---

## 📄 Page 2 — Spotify Audio Analytics

The second page focuses on the audio characteristics and distributions of the tracks.

### Audio Characteristics of Top 10 Popular Genres

Compares:

- Average Danceability
- Average Energy
- Average Valence

across the top 10 popular genres.

**Key insights:**
- Sad has the highest average danceability at approximately 0.69.
- Grunge has the highest average energy at approximately 0.80.
- Sertanejo has relatively high energy and valence.
- High energy does not necessarily correspond to high valence.

### Track Duration Distribution

A histogram showing how track durations are distributed.

**Key insights:**
- Most tracks are concentrated around approximately 2–4 minutes.
- The distribution is right-skewed.
- Very long tracks are relatively uncommon.

### Acousticness vs Instrumentalness

A scatter plot examining the relationship between acousticness and instrumentalness across genres.

**Key insights:**
- Most tracks have relatively low instrumentalness.
- Acousticness varies considerably.
- There is no strong visible relationship between acousticness and instrumentalness.

### Track Tempo Distribution

A histogram showing the distribution of track tempos.

**Key insights:**
- Most tracks fall broadly within the 80–160 BPM range.
- The distribution is concentrated around approximately 120–130 BPM.
- Extremely slow and extremely fast tracks are relatively uncommon.

---

## 🔄 Dashboard Interactivity

The dashboard supports interactive filtering and cross-highlighting.

Selections made in one visual affect the other visuals on the page, allowing the user to move from an overall view to a more focused analysis.

For example:

- Selecting an artist updates the KPI cards and related visuals.
- Selecting a genre filters the corresponding analysis.
- Selecting a data point in the scatter plot allows the selected observation to be investigated.
- KPI values dynamically change according to the active filter context.

---

## 🧮 DAX & Power BI Implementation

DAX was used to create the analytical measures required for the dashboard, including:

- Total track count
- Average popularity
- Average energy
- Average danceability
- Average valence
- Explicit and non-explicit track counts
- Top-N analysis

Conditional logic was also used to create dashboard-friendly categorical values.

Power BI's filter context and visual interactions were used to make the dashboard dynamically responsive to user selections.

---

## 🎯 Analytical Takeaways

The Power BI analysis highlights several patterns:

- Popularity varies considerably across genres and artists.
- Pop-film and K-pop are among the highest-ranked genres by average popularity.
- Energy has only a weak relationship with popularity.
- The dataset is predominantly non-explicit.
- Most tracks have durations between approximately 2 and 4 minutes.
- Track tempos are largely concentrated around the 120–130 BPM range.
- Musical characteristics such as danceability, energy and valence differ considerably across genres.
- High energy does not necessarily imply positive valence.
- Most tracks have relatively low instrumentalness.

---

## 🛠️ Power BI Skills Demonstrated

- Power BI Desktop
- Power Query
- DAX
- Data Transformation
- Data Modeling
- KPI Development
- Top-N Analysis
- Conditional Columns
- Interactive Visualizations
- Cross-filtering
- Scatter Plot Analysis
- Histogram Analysis
- Dashboard Design
- Data Storytelling
