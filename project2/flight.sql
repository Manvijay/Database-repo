CREATE TABLE flight(
    Origin Varchar(5),
    Destination Varchar(5),
    Cost Int,
    PRIMARY KEY (Origin, Destination) 
);

1)
INSERT INTO flight
VALUES('ATL','ORD',1000),('BUF','ORD',1500),('BUF','JFK',300),('JFK','ORD',200),('JFK','LAX',600),('BUF','LAX',2000),('LAX','LAS',500),
('JFK','CLT',150),('JFK','MIA',300),('BUF','BOS',150),('DTW','BUF',200),('LAX','SEA',100),('DTW','IAH',800),('IAH','EWR',870);

2)
with recursive cycle (origin,destination, total) as
(
	select * from flight 
    
    union all
    
    select distinct f.origin, c.destination, f.cost+ c.total 
    from flight f 
    join 
    cycle c 
    on f.destination= c.origin
)

select distinct  destination,MIN(total) from cycle where origin='BUF' group by destination;