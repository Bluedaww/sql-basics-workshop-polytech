UPDATE defi 
SET etat_validation = TRUE
WHERE montant_palier < 5000;