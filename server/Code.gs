function onFormSubmit(e) {
  var url = "https://bleusaille.emixam.be/google_form.php";

  var data =
  {
    "nom" : e.namedValues['Nom'][0],
    "prenom" : e.namedValues['Prénom'][0],
    "sexe": e.namedValues['Genre'][0],
    "adresse": e.namedValues['Adresse'],
    "daten": e.namedValues['Date de naissance'][0],
    "regio": e.namedValues['Regionale'][0],
    "resplegal": e.namedValues['Nom du responsable légal'][0] + ' ' + e.namedValues['Prénom du responsable légal'],
    'numresplegal':e.namedValues['Numéro de téléphone du responsable légale'][0],
    "tel" : e.namedValues['Numero de téléphone'][0]
  };
    
  var options =
  {
    "method" : "POST",
    "payload" : data, 
    "followRedirects" : false,
    "muteHttpExceptions": false
  };

  var result = UrlFetchApp.fetch(url, options);
  Logger.log(result.getResponseCode())
}