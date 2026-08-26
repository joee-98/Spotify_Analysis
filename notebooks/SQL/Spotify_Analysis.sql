show databases;
create database if not exists spotify;
use spotify;

drop table if exists spotify;

CREATE TABLE spotify (
    track_id VARCHAR(50),
    artist_name VARCHAR(255),
    album_name VARCHAR(255),
    track_name VARCHAR(255),
    popularity INT,
    duration_ms INT,
    explicit INT,
    danceability DOUBLE,
    energy DOUBLE,
    track_key INT,
    loudness DOUBLE,
    track_mode INT,
    speechiness DOUBLE,
    acousticness DOUBLE,
    instrumentalness DOUBLE,
    liveness DOUBLE,
    valence DOUBLE,
    tempo DOUBLE,
    time_signature INT,
    track_genre VARCHAR(100),
    duration_mins DOUBLE
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/spotify_final_clean.csv'
INTO TABLE spotify
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
 @track_id, @artist_name, @album_name, @track_name, @popularity,
 @duration_ms, @explicit, @danceability, @energy, @track_key,
 @loudness, @track_mode, @speechiness, @acousticness,
 @instrumentalness, @liveness, @valence, @tempo,
 @time_signature, @track_genre, @duration_mins
)
SET
 track_id = LEFT(@track_id, 50),
 artist_name = LEFT(@artist_name, 255),
 album_name = LEFT(@album_name, 255),
 track_name = LEFT(@track_name, 255),
 popularity = NULLIF(@popularity, ''),
 duration_ms = NULLIF(@duration_ms, ''),
 explicit = NULLIF(@explicit, ''),
 danceability = NULLIF(@danceability, ''),
 energy = NULLIF(@energy, ''),
 track_key = NULLIF(@track_key, ''),
 loudness = NULLIF(@loudness, ''),
 track_mode = NULLIF(@track_mode, ''),
 speechiness = NULLIF(@speechiness, ''),
 acousticness = NULLIF(@acousticness, ''),
 instrumentalness = NULLIF(@instrumentalness, ''),
 liveness = NULLIF(@liveness, ''),
 valence = NULLIF(@valence, ''),
 tempo = NULLIF(@tempo, ''),
 time_signature = NULLIF(@time_signature, ''),
 track_genre = @track_genre,
 duration_mins = NULLIF(@duration_mins, '');

select * from spotify limit 5;
select * from spotify ;
select count(*) from spotify;




-- 1) Top 10 artists who have the highest average popularity
select artist_name, avg(popularity) as avg_popularity from spotify group by artist_name order by avg_popularity desc limit 10;

	-- Insight:
-- Sam Smith/Kim Petras and Bizarrap/Quevedo have the highest average popularity
-- scores in the result. This shows that these artists or collaborations have
-- some of the most popular tracks in the dataset.

-- 2) Which genres have the highest average popularity?
select track_genre, avg(popularity) as avg_popularity from spotify group by track_genre order by avg_popularity desc limit 1;

	-- Insight:
-- Pop-film has the highest average popularity at 59.28. This means tracks in
-- the pop-film genre have a higher average popularity than the other genres
-- in the dataset.

-- 3) Are more danceable songs more popular?
select 
    case 
        when danceability > 0.7 then 'High'
        when danceability > 0.4 then 'Medium'
        else 'Low'
    end as dance_level,
    avg(popularity) as avg_popularity
from spotify
group by dance_level;

	-- Insight:
-- Medium-danceability songs have the highest average popularity at 34.50,
-- while highly danceable songs have an average of 32.68. This shows that
-- higher danceability does not always mean higher popularity.

-- 4) Which genre has the highest average energy?
select track_genre, round(avg(energy),2) as avg_energy from spotify group by track_genre order by avg_energy desc limit 1;

	-- Insight:
-- Death-metal has the highest average energy score at 0.93. This shows that
-- tracks in this genre are generally more intense and energetic than tracks
-- in the other genres.

-- 5) Which genres have the happiest songs (highest valence)?
select track_genre, round(avg(valence), 3) as avg_valence from spotify group by track_genre order by avg_valence desc limit 10;

	-- Insight:
-- Salsa has the highest average valence at 0.815, followed by forro and
-- rockabilly. This means songs in these genres generally have a more positive
-- and happy sound compared to the other genres in the result.

-- 6) Do explicit songs have higher average popularity than non-explicit ones?
select explicit, avg(popularity) as avg_popularity from spotify group by explicit order by avg_popularity;

	-- Insight:
-- Explicit songs have a higher average popularity of 36.52 compared to
-- 33.02 for non-explicit songs. In this dataset, explicit songs therefore
-- have a slightly higher average popularity.

-- 7) What is the average duration of songs by genre?
select track_genre, round(avg(duration_mins),2) as avg_duration from spotify group by track_genre order by avg_duration desc;

	-- Insight:
-- Detroit-techno has the longest average song duration at 6.20 minutes,
-- followed by minimal-techno and chicago-house. This shows that average
-- song length varies considerably between genres.

-- 8) Find songs that are both highly energetic and highly danceable
select track_name, energy, danceability from spotify where energy > 0.7 and danceability > 0.7;

	-- Insight:
-- Several tracks have both energy and danceability above 0.7. This shows
-- that the dataset contains many songs that are both energetic and suitable
-- for dance-focused listening.

-- 9) List top 10 most popular tracks with artist and genre
select track_name, artist_name, track_genre from spotify order by popularity desc limit 10;

	-- Insight:
-- Tracks such as "Unholy" by Sam Smith/Kim Petras and "Quevedo: Bzrp Music
-- Sessions, Vol. 52" appear among the most popular tracks. The top tracks
-- come from different artists and genres, showing that high popularity is
-- not limited to one genre.

-- 10) Are live songs (high liveness) more or less popular?
select case
          when liveness > 0.5 then 'more_live'
          else 'less_live'
		end as live_level,
avg(popularity) as avg_popularity from spotify group by live_level;

	-- Insight:
-- Songs with higher liveness have a slightly higher average popularity of
-- 33.53 compared to 33.31 for songs with lower liveness. The difference is
-- very small, so liveness does not appear to have a strong effect on
-- popularity in this dataset.

-- 11) Which genres should Spotify promote more to maximize user engagement?
select track_genre, avg(popularity) as avg_popularity from spotify 
	where energy > 0.7 or danceability > 0.7 group by track_genre order by avg_popularity desc limit 10;
    
	-- Insight:
-- Pop-film, K-pop, chill, and sad are among the genres with the highest
-- average popularity within the group of tracks that are either highly
-- energetic or highly danceable. This shows that both energetic and
-- danceable tracks can be popular across different genres.

-- 12) What combination of audio features (danceability, energy, valence) is common among top-performing tracks?
select track_name, popularity,
		round(avg(danceability) over(),2) as avg_danceability,
		round(avg(energy) over(),2) as avg_energy,
        round(avg (valence) over(),2) as avg_valence from spotify
	where popularity >=70
    order by popularity desc limit 1;
    
    -- Insight:
-- The query calculates the average danceability, energy, and valence for
-- tracks with popularity of 70 or above. These averages give an overall idea
-- of the audio characteristics found among highly popular tracks.

-- 13) Which artists consistently produce high-performing tracks and should be prioritized for partnerships?
select artist_name, count(*)as artist_track_count from spotify 
	where popularity>70 group by artist_name order by artist_track_count desc limit 5;

	-- Insight:
-- The artists with the highest number of tracks above the popularity score
-- of 70 have several highly popular songs in the dataset. This shows that
-- these artists have a consistent presence among popular tracks.
	
-- 14) Which genres are best suited for “happy”, “sad”, or “chill” playlists?
select
    track_genre,
    round(avg(valence),3) as avg_valence,
    round(avg(energy),3) as avg_energy,
    round(avg(acousticness),3) as avg_acousticness,
    round(avg(tempo),1) as avg_tempo,
    case
        when avg(energy) <= 0.5
             and avg(acousticness) >= 0.5
             and avg(valence) >= 0.5
        then 'Chill'
        when avg(valence) >= 0.6
        then 'Happy'
        when avg(valence) <= 0.4
        then 'Sad'
        else 'Neutral'
    end as mood
from spotify
group by track_genre
order by mood, avg_valence desc;

	-- Insight:
-- Honky-tonk and tango are classified as chill because of their lower energy
-- and higher acousticness. Salsa, forro, and rockabilly are classified as
-- happy because of their higher valence. These classifications are based on
-- the rules defined in the query.

-- 15) Do explicit songs perform better than non-explicit ones? Should Spotify promote or restrict them?
select explicit, avg(popularity) as avg_popularity from spotify group by explicit order by avg_popularity;

	-- Insight:
-- Explicit songs have an average popularity of 36.52 compared to 33.02 for
-- non-explicit songs. Therefore, explicit songs have slightly higher average
-- popularity in this dataset.

-- 16) What is the ideal song duration for higher popularity?
select round(avg(duration_mins),2) as ideal_duration from spotify where popularity > 70;

	-- Insight:
-- Songs with popularity above 70 have an average duration of about 3.84
-- minutes. This shows that highly popular songs in this dataset are around
-- four minutes long on average.

-- 17) Do users prefer high-energy songs or low-energy songs?
select count(case when energy>0.7 then 1 end) as high_enegy,
		count(case when energy<0.7 then 1 end) as low_energy from spotify;
        
        -- Insight:
-- There are 54,312 songs with energy above 0.7 and 59,034 songs with energy
-- below 0.7. This means the dataset contains slightly more songs below the
-- high-energy threshold than above it.
        
-- 18) Which tracks are ideal for “party playlists”?
select track_name, popularity from spotify where energy > 0.7 and danceability > 0.7 order by popularity desc limit 10;

	-- Insight:
-- "Me Porto Bonito" with a popularity of 97 and "I Ain't Worried" with a
-- popularity of 96 are among the most popular tracks that have both high
-- energy and high danceability. These tracks are examples of songs that
-- combine both characteristics with high popularity.

-- 19) Are certain genres overrepresented but underperforming?
select track_genre, count(track_genre) as genre_count, avg(popularity) as avg_popularity from spotify
	group by track_genre having genre_count > 100 and avg_popularity < 50 order by avg_popularity;
    
    -- Insight:
-- Genres such as Iranian, Romance, Latin, Detroit-techno, and Chicago-house
-- have relatively large numbers of tracks but lower average popularity.
-- This shows that having more tracks in a genre does not necessarily result
-- in higher average popularity.
    
-- 20) Do live tracks engage users more than studio recordings?
select case when liveness > 0.7 then 'live' else 'studio' end as track_type,
	avg(popularity) as avg_popularity from spotify
    group by track_type order by avg_popularity desc;
    
    -- Insight:
-- Tracks classified as live have an average popularity of 33.91, compared
-- with 33.30 for studio tracks. The difference is small, so live recordings
-- appear to have only a slight difference in popularity in this dataset
    
-- 21) Which genres are gaining popularity based on high average popularity but lower track count?
select track_genre, count(track_genre) as genre_count, avg(popularity) as avg_popularity from spotify
	group by track_genre having genre_count < 100 and avg_popularity > 70 order by avg_popularity desc;
    
    -- Insight:
-- No genres satisfy both conditions. This means there are no genres in this
-- dataset with fewer than 100 tracks that also have an average popularity
-- above 70.

-- 22) Which audio feature has the strongest relationship with popularity?
select 
-- Energy
(
    COUNT(*) * SUM(popularity * energy) - SUM(popularity) * SUM(energy)
) /
SQRT(
    (COUNT(*) * SUM(POW(popularity,2)) - POW(SUM(popularity),2)) *
    (COUNT(*) * SUM(POW(energy,2)) - POW(SUM(energy),2))
) AS energy_corr,

-- Danceability
(
    COUNT(*) * SUM(popularity * danceability) - SUM(popularity) * SUM(danceability)
) /
SQRT(
    (COUNT(*) * SUM(POW(popularity,2)) - POW(SUM(popularity),2)) *
    (COUNT(*) * SUM(POW(danceability,2)) - POW(SUM(danceability),2))
) AS dance_corr,

-- Valence
(
    COUNT(*) * SUM(popularity * valence) - SUM(popularity) * SUM(valence)
) /
SQRT(
    (COUNT(*) * SUM(POW(popularity,2)) - POW(SUM(popularity),2)) *
    (COUNT(*) * SUM(POW(valence,2)) - POW(SUM(valence),2))
) AS valence_corr,

-- Tempo
(
    COUNT(*) * SUM(popularity * tempo) - SUM(popularity) * SUM(tempo)
) /
SQRT(
    (COUNT(*) * SUM(POW(popularity,2)) - POW(SUM(popularity),2)) *
    (COUNT(*) * SUM(POW(tempo,2)) - POW(SUM(tempo),2))
) AS tempo_corr

FROM spotify;

	-- Insight:
-- Danceability has the strongest positive correlation with popularity at
-- 0.0344, followed by tempo at 0.0122. However, all the correlation values
-- are very close to zero. This means these individual audio features have
-- very weak relationships with popularity in this dataset.

-- 23) Do songs with multiple artists perform better than solo artist songs?
select case when artist_name like '%;%' then 'multiple_artist'
			else 'single_artist' end as artist_type, 
		avg(popularity) as avg_popularity from spotify
		group by artist_type order by avg_popularity desc;
        
	-- Insight:
-- Tracks with multiple artists have an average popularity of 33.86 compared
-- to 33.13 for solo artist tracks. Collaborations therefore have a slightly
-- higher average popularity in this dataset.

-- 24) Which tracks have strong audio features but low popularity (hidden gems)?
select track_name, popularity, energy, valence, danceability from spotify
		where energy > 0.7 and danceability > 0.7 and valence > 0.7 and popularity < 60
        order by popularity;
        
	-- Insight:
-- Some tracks have high energy, danceability, and valence but still have
-- very low popularity. This shows that strong audio features alone do not
-- guarantee that a song will become popular.

-- 25) How can Spotify cluster songs into segments (party, chill, sad, workout)?
select 
		case
			when valence > 0.8 then 'party'
            when valence > 0.6 then 'chill'
            when valence > 0.4 then 'workout'
            else 'sad'
		end as segment,
        count(*) as total_tracks, avg(popularity) as avg_popularity
        from spotify
        group by segment;
        
	-- Insight:
-- The dataset contains the most songs in the sad segment, followed by
-- workout, chill, and party. The average popularity is fairly similar across
-- the four groups, so no single segment is clearly much more popular than
-- the others.
        
-- 26) What % of songs are “hit songs”?
select 
	round(
		count( case when popularity > 70 then 1 end) *100.0/count(*),2) as hit_percent
	from spotify;
    
    -- Insight:
-- Only 4.27% of the songs have a popularity score above 70. This means
-- highly popular songs make up only a small part of the entire dataset.

-- 27) What % of songs fall into each energy segment?
select
	energy_segment, total_tracks, segment_percent,
    sum(segment_percent) over(ORDER BY segment_percent DESC) as cum_percent
from (
		select
				case when energy > 0.7 then 'High_energy'
					when energy between 0.4 and 0.7 then 'Medium_energy'
					else 'Low_energy' 
				end as energy_segment,
				count(*) as total_tracks,
				round(
				count(*)*100/sum(count(*)) over(),2) as segment_percent
		 from spotify
		group by energy_segment
	) t
order by segment_percent desc;

	-- Insight:
-- High-energy songs make up 47.83% of the dataset, medium-energy songs make
-- up 33.67%, and low-energy songs make up 18.50%. This shows that high-energy
-- songs form the largest energy group in the dataset.
        
-- 28) What % of total tracks does each genre contribute?
select track_genre,
round(
	count(*)*100.0/sum(count(*)) over(),2) as genre_precent
     from spotify
group by track_genre;

	-- Insight:
-- Each genre contributes around 0.88% of the total tracks. This shows that
-- the dataset is evenly distributed across the different genres.

-- 29) Which genres contribute most to total popularity?
select track_genre, track_genre_contr,
sum(track_genre_contr) over(order by track_genre_contr desc) as cum
from (
select track_genre,
 round(
	sum(popularity)*100.0/sum(sum(popularity)) over(),2) as track_genre_contr
from spotify
group by track_genre
) t
order by track_genre_contr desc;

	-- Insight:
-- Pop-film contributes 1.57% of the total popularity, followed by K-pop at
-- 1.50% and chill at 1.42%. This shows that these genres have a slightly
-- larger share of the overall popularity in the dataset.

-- 30) What % of total popularity comes from explicit songs?
select
sum(popularity) as total_popularity,
case
	when explicit = 1 then 'explicit_songs'
    else 'non_explicit_songs' 
end as explicit_segregation,
round(
sum(popularity)*100.0/sum(sum(popularity)) over(),2) as explicit_contribution
from spotify
group by explicit_segregation;

	-- Insight:
-- Non-explicit songs contribute 90.62% of the total popularity, while
-- explicit songs contribute 9.38%. This means most of the total popularity
-- in the dataset comes from non-explicit songs.

-- 31) What % of songs in each genre are hits?
select track_genre, songs_count, popular_songs_count, genre_hits_percent,
sum(genre_hits_percent) over( order by genre_hits_percent desc) as cum
from (
select track_genre, songs_count, popular_songs_count,
round(
popular_songs_count*100.0/nullif(songs_count,0),2) as genre_hits_percent
 from (
select track_genre, count(*) as songs_count,

	sum(case when popularity > 70 then 1 end) as popular_songs_count
 from spotify group by track_genre
 ) t
 ) tt
order by genre_hits_percent desc;

	-- Insight:
-- Pop has the highest percentage of hit songs at 28.40%, followed by dance
-- and electro. This means a larger share of songs in these genres have a
-- popularity score above 70 compared with many other genres.

-- 32) “What % of total popularity is contributed by the top 25% vs bottom 25% of songs?”
select count(*) as total_songs, popularity_segment,
sum(popularity)*100.0/sum(sum(popularity)) over() as percent_popularity
from (
select popularity,
case 
	when ntile(4) over(order by popularity desc) =1 then "Top25%"
    when ntile(4) over (order by popularity desc)=4 then 'Bottom25%'
    else 'Middle50%'
end as popularity_segment
from spotify
) t
where popularity_segment is not null
group by popularity_segment;

	-- Insight:
-- The top 25% of songs contribute 46.40% of the total popularity, while the
-- bottom 25% contribute only 2.79%. This shows that popularity is not evenly
-- distributed across the songs.

-- 33) What % of high-energy songs are also highly popular?
select
    count(*) as high_energy_songs,
    SUM(case when popularity > 70 then 1 else 0 end) as high_popular_songs,
    ROUND(
        SUM(case when popularity > 70 then 1 else 0 end) * 100.0 / COUNT(*),
        2
    ) as high_popular_percent
from spotify
where energy > 0.7;

	-- Insight:
-- There are 54,312 high-energy songs, but only 2,441 of them have a
-- popularity score above 70. This means only 4.49% of high-energy songs are
-- highly popular. Therefore, high energy alone does not guarantee high
-- popularity.

-- 34) Top 10 artists contribute what % of total popularity?
select
    sum(artist_total_popularity) as top_10_total_popularity,
    round(
        sum(artist_total_popularity) * 100.0 /
        (select sum(popularity) from spotify),
        2
    ) as top_10_contribution_percent
from (
    select
        artist_name,
        sum(popularity) as artist_total_popularity
    from spotify
    group by artist_name
    order by artist_total_popularity desc
    limit 10
) as top_artists;

	-- Insight:
-- The top 10 artists contribute 2.46% of the total popularity in the dataset.
-- This shows that total popularity is spread across many artists rather than
-- being concentrated among only the top 10 artists.

-- 35) What % of total hits come from collaborations?

select
    count(*) as total_hits,
    sum(
        case
            when artist_name like '%;%' then 1
            else 0
        end
    ) as collaboration_hits,
    round(
        sum(
            case
                when artist_name like '%;%' then 1
                else 0
            end
        ) * 100.0 / COUNT(*),
        2
    ) as collaboration_hit_percent
from spotify
where popularity > 70;

	-- Insight:
-- There are 4,843 hit songs in total, and 1,421 of them are collaborations.
-- This means 29.34% of the hit songs involve multiple artists, showing that
-- collaborations are fairly common among popular songs in the dataset.