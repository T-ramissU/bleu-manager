function onFormSubmit(e) {
  var url = "https://bleusaille.emixam.be/google_form.php";

  var data =
  {
    "nom" : e.namedValues['Nom'][0],
    "prenom" : e.namedValues['Prenom'][0],
    "matricule" : e.namedValues['matricule'][0],
    "regio": e.namedValues['regio'][0],
    "med": e.namedValues['probleme medicaux ( ne répondre que si vous en avez)'][0],
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