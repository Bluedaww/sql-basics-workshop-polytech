-- ============================================
-- Exercice 1 : Insertion des données
-- Réalisé par : Authier Lucas
-- Date : 18/05/2026
-- ============================================

-- 1. Insertion des données dans la table Streamer
-- La table streamer stocke tous les pseudos des streamers du Zevent 
-- ainsi que le lien vers leur chaine twitch et un identifiant qui s'auto-incrémente

INSERT INTO Streamer (pseudo, url_twitch)
VALUES
	('Zerator','https://www.twitch.tv/zerator'),
	('Domingo', 'https://www.twitch.tv/domingo'),
	('Etoiles', 'https://www.twitch.tv/etoiles'),
	('Lapi', 'https://www.twitch.tv/lapi'),
	('Sakor', 'https://www.twitch.tv/sakor'),
	('Wakzlol', 'https://www.twitch.tv/wakzlol'),
	('Jiraya', 'https://www.twitch.tv/jiraya'),
	('BagheraJones', 'https://www.twitch.tv/bagherajones'),
	('MisterMV', 'https://www.twitch.tv/mistermv'),
	('LittleBigWhale', 'https://www.twitch.tv/littlebigwhale');

-- 2. Insertion des données dans la table Creneau
-- La table créneau stocke les créneaux de streaming autorisés pour chaque streamer pendant le Zevent
-- Chaque créneau est défini par une date de début autorisée et une date de fin autorisée, ainsi que l'identifiant du streamer concerné
INSERT INTO Creneau (date_debut_autorisee, date_fin_autorisee, id_streamer)
VALUES
    -- Jour 1 : 2026-09-04 (4 streamers)
    ('2026-09-04 06:00:00+01', '2026-09-04 18:00:00+01', 1),
    ('2026-09-04 10:00:00+01', '2026-09-04 22:00:00+01', 2),
    ('2026-09-04 14:00:00+01', '2026-09-05 02:00:00+01', 3),
    ('2026-09-04 18:00:00+01', '2026-09-05 06:00:00+01', 4),
    -- Jour 2 : 2026-09-05 (3 streamers)
    ('2026-09-05 02:00:00+01', '2026-09-05 14:00:00+01', 5),
    ('2026-09-05 10:00:00+01', '2026-09-05 22:00:00+01', 6),
    ('2026-09-05 16:00:00+01', '2026-09-06 04:00:00+01', 7),
    -- Jour 3 : 2026-09-06 (3 streamers)
    ('2026-09-06 01:00:00+01', '2026-09-06 13:00:00+01', 8),
    ('2026-09-06 06:00:00+01', '2026-09-06 18:00:00+01', 9),
    ('2026-09-06 11:00:00+01', '2026-09-06 23:00:00+01', 10),
	-- Jour 1 : 2026-09-04 (4 streamers)
    ('2026-09-04 06:00:00+01', '2026-09-04 18:00:00+01', 10),
    ('2026-09-04 10:00:00+01', '2026-09-04 22:00:00+01', 9),
    ('2026-09-04 14:00:00+01', '2026-09-05 02:00:00+01', 8),
    ('2026-09-04 18:00:00+01', '2026-09-05 06:00:00+01', 7),
    -- Jour 2 : 2026-09-05 (3 streamers)
    ('2026-09-05 02:00:00+01', '2026-09-05 14:00:00+01', 1),
    ('2026-09-05 10:00:00+01', '2026-09-05 22:00:00+01', 2),
    ('2026-09-05 16:00:00+01', '2026-09-06 04:00:00+01', 3),
    -- Jour 3 : 2026-09-06 (3 streamers)
    ('2026-09-06 01:00:00+01', '2026-09-06 13:00:00+01', 4),
    ('2026-09-06 06:00:00+01', '2026-09-06 18:00:00+01', 5),
    ('2026-09-06 11:00:00+01', '2026-09-06 23:00:00+01', 6);

-- 3. Insertion des données dans la table Défi
-- La table défi stocke tous les défis du Zevent, leur montant de palier et leur état de validation (validé ou non)
INSERT INTO defi(intitule, montant_palier, etat_validation) 
VALUES 
    ('Karaoke', 500, false),
    ('Just Dance',1000,false),
    ('Cosplay imposé pendant tout le reste du live',2500,false),
    ('Jouer en courant sur un tapis de course',5000,false),
    ('Tout le monde fait un speedrun',10000,false),
    ('Soirée dégustation de piments et anecdotes',20000,false),
    ('Le streamer laisse le chat contrôler les sons et alertes pendant 1 heure',35000,false),
    ('Sauter en parachute',50000,false),
    ('Culture clash du Zevent',75000,false),
    ('Rasage des cheveux',100000,false);

-- 4. Insertion des données dans la table Participation_defi
-- La table participation_defi stocke les participations des streamers aux différents défis du Zevent
INSERT INTO participation_defi( id_streamer, id_defi) 
    VALUES 
        ('1','1'),
        ('6','2'),
        ('6','3'),
        ('3','3'),
        ('3','4'),
        ('4','4'),
        ('5','4'),
        ('1','5'),
        ('8','6'),
        ('9','7'),
        ('1','8'),
        ('10','8'),
        ('2','8'),
        ('8','9'),
        ('7','9');

-- 5. Insertion des données dans la table Stream
-- Chaque stream doit respecter les bornes de son créneau (heure_debut >= date_debut_autorisee, heure_fin <= date_fin_autorisee)
-- date_fin_effective est NULL si le stream n'est pas encore terminé
INSERT INTO stream (id_streamer, id_creneau, titre, heure_debut, heure_fin, date_fin_effective)
VALUES
    -- Zerator sur créneau 1 (04/09 06h-18h)
    (1,  31,  'Zerator ouvre le Zevent !',                   '2026-09-04 08:00:00+01', '2026-09-04 14:00:00+01', '2026-09-04 14:15:00+01'),

    -- Domingo sur créneau 2 (04/09 10h-22h)
    (2,  32,  'Domingo en mode marathon',                    '2026-09-04 11:00:00+01', '2026-09-04 20:00:00+01', '2026-09-04 20:00:00+01'),

    -- Etoiles sur créneau 3 (04/09 14h - 05/09 02h)
    (3,  33,  'Etoiles parle de culture',                   '2026-09-04 15:00:00+01', '2026-09-04 23:00:00+01', NULL),

    -- Lapi sur créneau 4 (04/09 18h - 05/09 06h)
    (4,  34,  'Nuit blanche avec Lapi',                     '2026-09-04 19:00:00+01', '2026-09-05 03:00:00+01', '2026-09-05 03:30:00+01'),

    -- Sakor sur créneau 5 (05/09 02h-14h)
    (5,  35,  'Sakor et le réveil difficile',               '2026-09-05 03:00:00+01', '2026-09-05 12:00:00+01', '2026-09-05 12:00:00+01'),

    -- Wakzlol sur créneau 6 (05/09 10h-22h)
    (6,  36,  'Wakzlol en live tranquille',                 '2026-09-05 11:00:00+01', '2026-09-05 20:00:00+01', NULL),

    -- Jiraya sur créneau 7 (05/09 16h - 06/09 04h)
    (7,  37,  'Jiraya sur un jeux d''horreur',                   '2026-09-05 17:00:00+01', '2026-09-06 02:00:00+01', '2026-09-06 02:00:00+01'),

    -- BagheraJones sur créneau 8 (06/09 01h-13h)
    (8,  38,  'BagheraJones aux aurores',                   '2026-09-06 02:00:00+01', '2026-09-06 11:00:00+01', '2026-09-06 12:00:00+01'), -- dépassement

    -- MisterMV sur créneau 9 (06/09 06h-18h)
    (9,  39,  'MisterMV se balade',         '2026-09-06 08:00:00+01', '2026-09-06 16:00:00+01', NULL),

    -- LittleBigWhale sur créneau 10 (06/09 11h-23h)
    (10, 40, 'LittleBigWhale sur PUBG',           '2026-09-06 12:00:00+01', '2026-09-06 22:00:00+01', '2026-09-06 22:00:00+01'),

    -- LittleBigWhale sur créneau 11 (04/09 06h-18h, 2e créneau)
    (10, 41, 'LittleBigWhale chante',     '2026-09-04 07:00:00+01', '2026-09-04 16:00:00+01', '2026-09-04 16:30:00+01'),

    -- MisterMV sur créneau 12 (04/09 10h-22h, 2e créneau)
    (9,  42, 'Double session pour MisterMV',               '2026-09-04 11:00:00+01', '2026-09-04 20:00:00+01', NULL),

    -- Zerator sur créneau 15 (05/09 02h-14h, 2e créneau)
    (1,  45, 'Zerator enchaîne sur la nuit',               '2026-09-05 04:00:00+01', '2026-09-05 12:00:00+01', '2026-09-05 12:00:00+01'),

    -- Domingo sur créneau 16 (05/09 10h-22h, 2e créneau)
    (2,  46, 'Domingo revient en forme',                   '2026-09-05 12:00:00+01', '2026-09-05 21:00:00+01', NULL),

    -- Etoiles sur créneau 17 (05/09 16h - 06/09 04h, 2e créneau)
    (3,  47, 'Etoiles dj set',              '2026-09-05 18:00:00+01', '2026-09-06 02:00:00+01', '2026-09-06 03:00:00+01'); -- dépassement