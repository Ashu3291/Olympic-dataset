

* OLYMPICS DATASET * 

select * from athlete_events;

select * from noc_regions;



1. How many olympics games have been held?

    select count(distinct games) as total_olympic_games
    from athlete_events;


	2. List down all Olympics games held so far. (Data issue at 1956-"Summer"-"Stockholm")

    select distinct year,season,city
    from athlete_events 
    order by year;

	3. Mention the total no of nations who participated in each olympics game?

	select Games,count(distinct region) as team_count from athlete_events as a
	join noc_regions as n on a.NOC=n.NOC
	group by Games
	order by games;

	4. Which nation has participated in all of the olympic games

	select count(distinct games) as 'total_games' from athlete_events;
	select region as country,count(distinct games) as 'total_games' from athlete_events AS a
	JOIN noc_regions AS n ON a.NOC = n.NOC
	group by region
	having 'total_games' = (select count(distinct games) from athlete_events);


	5. Identify the sports which was played in all the summer olympics?
	select Sport, count(distinct Games) as No_Of_Sports
	from athlete_events
	where Season = 'summer'
	group by Sport
	Having count(distinct Games)=( select COUNT(Distinct Games) from athlete_events where athlete_events.Season = 'summer');

	6. Which Sports were just played only once in the olympics?

	select Sport, count(distinct Games) as No_Of_Sports
	from athlete_events
	where Season = 'summer'
	group by Sport
	Having count(distinct Games)<=1

	7. Fetch the total no of sports played in each olympic games.
	select Games,count(distinct Sport) as No_Of_Games
	from athlete_events
	group by Games
	order by 2 desc;

	8. Fetch details of the oldest athletes to win a gold medal.

	select *
	from athlete_events
	where Medal = 'Gold' and Age = (select max(Age) from athlete_events where Medal = 'Gold');


	9.Fetch the top 5 athletes who have won the most gold medals.
	with cteGoldWinner as (
	select Name, team, COUNT (medal) as Count_Of_Medals,
	dense_Rank () over (order by COUNT (medal) desc) as Ranking
	from athlete_events
	where Medal = 'Gold'
	group by Name, Team)
	select * from cteGoldWinner
	where Ranking <= 5
	order by Ranking;

	10.Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).

	with cte as (
	select name,team,count(medal) as Total_gold_medal ,
	dense_rank() over ( order by count(medal) desc) as rnk
	from athlete_events
	where medal in ('gold','silver','bronze')
	group by name,team)
	select name,team,Total_gold_medal from cte
	where rnk <= 5;

	11.Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won

	select region ,count(medal) as Total_medal_win,
	dense_rank() over (order by count(medal) desc ) as rnk
	from athlete_events AS a
	JOIN noc_regions AS n ON a.NOC = n.NOC
	where medal in ('gold','silver','bronze')
	group by region
	order by Total_medal_win desc; 

	12. List down total gold, silver and bronze medals won by each country.

	SELECT region,
	COUNT(CASE WHEN medal = 'Gold' THEN medal END) AS Gold_medal,
	COUNT(CASE WHEN medal = 'Silver' THEN medal END) AS Silver_medal,
	COUNT(CASE WHEN medal = 'Bronze' THEN medal END) AS Bronze_medal	
	FROM athlete_events AS a
	JOIN noc_regions AS n ON a.NOC = n.NOC
	GROUP BY region
	order by Gold_medal desc;

	13. List down total gold, silver and bronze medals won by each country corresponding to each olympic games.

	SELECT games, region,
	COUNT(CASE WHEN medal = 'Gold' THEN medal END) AS Gold_medal,
	COUNT(CASE WHEN medal = 'Silver' THEN medal END) AS Silver_medal,
	COUNT(CASE WHEN medal = 'Bronze' THEN medal END) AS Bronze_medal
	FROM athlete_events AS a
	JOIN noc_regions AS n ON a.NOC = n.NOC
	GROUP BY games,region
	order by games;

	
	14. In which Sport/event, India has won highest medals.

	select sport,count(medal) as Total_medal FROM athlete_events AS a
	JOIN noc_regions AS n ON a.NOC = n.NOC
	where region = 'India'
	group by sport
	order by Total_medal desc

	15. Break down all olympic games where India won medal for Hockey and how many medals in each olympic games

	SELECT team, sport, games, COUNT(medal) AS Total_medal
	FROM athlete_events
	WHERE team = 'India' AND sport = 'Hockey' and medal <> 'NA'
	GROUP BY team, sport, games
	ORDER BY Total_medal desc


	----- THE END ----