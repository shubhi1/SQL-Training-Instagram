-- 5 oldest users
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

-- what day most users register on
SELECT 
	COUNT(*) AS Users_register,
	DAYNAME(created_at) AS DAY 
FROM users
GROUP BY DAY
ORDER BY Users_register DESC;

-- Inactive users who never posted photos
SELECT 
ROW_NUMBER() OVER(),
users.id,
username,
users.created_at
FROM users
LEFT JOIN photos 
	ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- user which get most liked photo
SELECT COUNT(photo_id), photo_id
FROM likes
GROUP BY photo_id;

Select 
	users.id,
    users.username,
-- 	photos.user_id,
--    likes.photo_id,
    COUNT(*) AS No_of_likes
FROM photos
INNER JOIN likes 
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY likes.photo_id
ORDER BY No_of_likes DESC
LIMIT 1;

-- how many time s an AVG user post
SELECT 
(SELECT Count(*) FROM photos) / (SELECT Count(*) FROM users) AS avg; 

-- Top 5 most commonly used hashtags
SELECT 
	COUNT(*) AS total_tags, 
    tag_id,
    tag_name
FROM photo_tags
INNER JOIN tags
	ON tag_id = id
GROUP BY tag_id
ORDER BY total_tags DESC
LIMIT 10;

-- Find users who liked every photos
SELECT username, 
	Count(*) AS total_likes 
FROM users 
INNER JOIN likes 
	ON users.id = likes.user_id 
GROUP BY likes.user_id 
HAVING total_likes = (SELECT Count(*) FROM photos); 