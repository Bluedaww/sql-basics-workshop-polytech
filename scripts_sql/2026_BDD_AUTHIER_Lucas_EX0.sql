-- ============================================
-- Exercice 0 : Création des tables
-- Réalisé par : Authier Lucas
-- Date : 18/05/2026
-- ============================================

-- 1. Création des tables
CREATE TABLE Streamer(
   id_streamer SERIAL,
   pseudo VARCHAR(50),
   url_twitch VARCHAR(150),
   PRIMARY KEY(id_streamer),
   UNIQUE(pseudo)
);

CREATE TABLE Creneau(
   id_creneau SERIAL,
   date_debut_autorisee TIMESTAMP with TIME ZONE NOT NULL,
   date_fin_autorisee TIMESTAMP with TIME ZONE NOT NULL,
   id_streamer INT NOT NULL,
   PRIMARY KEY(id_creneau),
   FOREIGN KEY(id_streamer) REFERENCES Streamer(id_streamer)
);

CREATE TABLE Stream(
   id_stream SERIAL,
   titre VARCHAR(50),
   heure_debut TIMESTAMP with TIME ZONE NOT NULL,
   heure_fin TIMESTAMP with TIME ZONE NOT NULL,
   date_fin_effective TIMESTAMP with TIME ZONE,
   id_streamer INT NOT NULL,
   id_creneau INT NOT NULL,
   PRIMARY KEY(id_stream),
   FOREIGN KEY(id_streamer) REFERENCES Streamer(id_streamer),
   FOREIGN KEY(id_creneau) REFERENCES Creneau(id_creneau)
);

CREATE TABLE Defi(
   id_defi SERIAL,
   intitule VARCHAR(150),
   montant_palier DECIMAL(12,2),
   etat_validation BOOLEAN,
   PRIMARY KEY(id_defi)
);

CREATE TABLE Participation_defi(
   id_streamer INT,
   id_defi INT,
   PRIMARY KEY(id_streamer, id_defi),
   FOREIGN KEY(id_streamer) REFERENCES Streamer(id_streamer),
   FOREIGN KEY(id_defi) REFERENCES Defi(id_defi)
);
