# Global Music Streaming & Platform Exclusivity Analytics (Relational SQL & Tableau)

🔗 **[Live Interactive Tableau Dashboard](https://public.tableau.com/views/GlobalMusicStreamingPlatformExclusivityAnalytics/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

## Project Overview
This project focuses on analyzing market trends, catalog performance, and the financial viability of platform-exclusive distribution deals within the music streaming industry. Moving beyond flat-file analysis, this project utilizes a normalized relational database structure across separate metadata and streaming performance tables. By writing intermediate SQL queries (including multi-table joins, compound filtering, and post-group aggregations) and building an interactive dashboard layout, this analysis identifies total playlist reach and actual stream conversion for executive stakeholders.

## Technical Skills Demonstrated
* **Database Querying:** Advanced Aggregations, Multi-table `LEFT JOIN` and `INNER JOIN` operations, Grouping logic, Post-aggregation filtering (`HAVING`).
* **Data Engineering:** Relational Schema Design, Primary/Foreign Key constraints.
* **Business Intelligence:** Relational data modeling, data extracts, and interactive dashboarding inside Tableau with bidirectional filtering.

## Relational Database Structure
The project utilizes two separate datasets linked together by a unique primary/foreign key (`track_id`):
1. `tracks`: Contains static metadata (`title`, `artist`, `genre`, `release_year`, `platform_exclusive`).
2. `streaming_stats`: Contains dynamic performance metrics in millions (`global_streams`, `playlist_count`).

## Key Queries & Insights

### 1. The Ultimate Streaming Summary (The Big 6 Masterclass)
* **Objective:** Evaluate older "catalog music" (released before 2020) to identify which major genres command user playlist placements, filtering out low-volume, niche genres.
* **SQL Query:**
SELECT tracks.genre as 'Genre', SUM(streaming_stats.global_streams) as 'Total Global Streams', SUM(streaming_stats.playlist_count) as 'Total Playlist Count' FROM tracks LEFT JOIN streaming_stats ON tracks.track_id = streaming_stats.track_id WHERE release_year < 2020 GROUP BY genre HAVING SUM(streaming_stats.playlist_count) > 10;

### 2. Platform Exclusivity Analysis (Inner Join & ROI Assessment)
* **Objective:** Measure the performance of platform-exclusive distribution deals by comparing total track counts and average streaming volumes against non-exclusive tracks to determine organizational ROI.
* **SQL Query:**
SELECT platform_exclusive as 'Platform Exclusive', COUNT(tracks.track_id) as 'Track Count', AVG(global_streams) as 'Average Global Streams' FROM tracks INNER JOIN streaming_stats ON tracks.track_id = streaming_stats.track_id GROUP BY platform_exclusive;

### 3. Identifying High-Velocity Outliers (Multi-Condition Filtering)
* **Objective:** Isolate recent breakout hits by identifying individual artists and tracks released from 2018 onward that have crossed the 2 billion global stream milestone.
* **SQL Query:**
SELECT artist as 'Artist', title as 'Song Title', release_year as 'Release Year', streaming_stats.global_streams as 'Global Streams' FROM tracks LEFT JOIN streaming_stats ON tracks.track_id = streaming_stats.track_id WHERE release_year >= 2018 AND global_streams > 2000.0 ORDER BY global_streams DESC;

## Data Visualization (Tableau)
By mirroring the relational data joins inside Tableau, the interactive dashboard transforms these row-level outputs into dynamic visual insights:
* **Genre Playlist Dominance:** A horizontal bar chart tracking cumulative playlist reach, using a continuous color gradient scale mapped to global streams to isolate high-performers.
* **Exclusivity Impact Analysis:** A side-by-side column chart contrasting average streaming performance benchmarks against gross track volume across exclusive categories.

## Core Conclusions
* **Filter Threshold Mechanics:** Adjusting filter parameters to apply after aggregations allows for comprehensive tracking of collective genre volume, preventing the accidental bottlenecking of valid metadata groups.
* **Exclusivity Dynamics:** Analyzing the trade-off between total track volume and average streaming yield helps stakeholders visualize whether platform-exclusive catalog deals produce a higher return on investment compared to open distribution networks.
