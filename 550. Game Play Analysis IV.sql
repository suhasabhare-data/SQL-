Create table If Not Exists Activity (player_id int, device_id int, event_date date, games_played int);

insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5');
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6');
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0');
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5');

SELECT 
    ROUND(COUNT(DISTINCT a1.player_id) / 
    (SELECT COUNT(DISTINCT player_id) FROM Activity),2) AS fraction
FROM Activity a1
JOIN Activity a2
  ON a1.player_id = a2.player_id
 AND a1.event_date = a2.event_date + INTERVAL 1 DAY;
 
SELECT COUNT(player_id) AS TOTAL_PLAYERS, NULL AS event_date
FROM Activity
UNION
SELECT a1.player_id, a1.event_date
FROM Activity a1
JOIN Activity a2
  ON a1.player_id = a2.player_id
 AND a1.event_date = a2.event_date + INTERVAL 1 DAY;
 
 
 WITH PlayerFirstLogin
AS (
	SELECT player_id
		,min(event_date) AS first_login_date
	FROM Activity
	GROUP BY player_id
	)
	,PlayerConsecutiveLogin
-- Get players players that logged in for at least two consecutive days starting from their first login date
AS (
	SELECT A.player_id
	FROM Activity AS A
	INNER JOIN PlayerFirstLogin FL ON A.player_id = FL.player_id
		AND datediff(A.event_date, FL.first_login_date) = 1
	)
-- Report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
SELECT cast((
			SELECT count(DISTINCT player_id)
			FROM PlayerConsecutiveLogin
			) / cast((
				SELECT count(DISTINCT player_id)
				FROM Activity
				) AS FLOAT) AS DECIMAL(10, 2)) AS fraction