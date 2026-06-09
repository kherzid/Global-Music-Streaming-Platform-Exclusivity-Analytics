-- 1. Evaluate older "catalog music" (released before 2020) to identify which major genres command user playlist placements, filtering out low-volume, niche genres.
SELECT tracks.genre as 'Genre',
sum(streaming_stats.global_streams) as 'Total Global Streams',
sum(streaming_stats.playlist_count) as 'Total Playlist Count' 
FROM tracks LEFT JOIN streaming_stats
ON tracks.track_id = streaming_stats.track_id
WHERE release_year < 2020
GROUP BY genre
HAVING sum(streaming_stats.playlist_count) > 50;

-- 2. Measure the performance of platform-exclusive distribution deals by comparing total track counts and average streaming volumes against non-exclusive tracks.
SELECT platform_exclusive as 'Platform Exclusive', 
count(tracks.track_id) as 'Track Count', 
avg(global_streams) as 'Average Global Streams'
FROM tracks INNER JOIN streaming_stats 
ON tracks.track_id = streaming_stats.track_id
GROUP BY platform_exclusive;

--3. Isolate recent breakout hits by identifying individual artists and tracks released from 2018 onward that have crossed the 2 billion global stream milestone.
SELECT artist as 'Artist', 
title as 'Song Title', 
release_year as 'Release Year', 
streaming_stats.global_streams as 'Global Streams'
FROM tracks LEFT JOIN streaming_stats
ON tracks.track_id = streaming_stats.track_id
WHERE release_year >= 2018 AND global_streams > 2000.0
ORDER BY global_streams DESC;

