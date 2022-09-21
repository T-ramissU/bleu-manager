function onFormSubmit(e) {
  var url = "https://bleusaille.emixam.be/google_form.php";
  
  var data =
  {
    "nom" : e.namedValues['Nom'][0],
    "prenom" : e.namedValues['Prénom'][0],
    "sexe": e.namedValues['Genre'][0],
    "adresse": e.namedValues['Adresse'][0],
    "daten": e.namedValues['Date de naissance'][0],
    "regio": e.namedValues['Régionale'][0],
    "resplegal": e.namedValues['Nom du responsable légal'][0] + ' ' + e.namedValues['Prénom du responsable légal'],
    'numresplegal':e.namedValues['Numéro de téléphone du responsable légal'][0],
    "tel" : e.namedValues['Numéro de téléphone'][0], 
  };
    
  var options =
  {
    "method" : "POST",
    "payload" : data, 
    "followRedirects" : false,
    "muteHttpExceptions": false
  };

  UrlFetchApp.fetch(url, options);
}

function sendAll() {
  var sheet = SpreadsheetApp.getActive().getSheetByName("Réponses au formulaire 1");
  var data = sheet.getDataRange().getValues();

  data.forEach(function (row) {
    var url = "https://bleusaille.emixam.be/google_form.php";
    
    var data =
    {
      "nom" : row[1],
      "prenom" : row[2],
      "sexe": row[5],
      "adresse": row[3],
      "daten": row[4],
      "regio": row[9],
      "resplegal": row[20] + ' ' + row[21],
      'numresplegal': row[23],
      "tel" : row[8], 
    };
      
    var options =
    {
      "method" : "POST",
      "payload" : data, 
      "followRedirects" : false,
      "muteHttpExceptions": false
    };
    try {
      UrlFetchApp.fetch(url, options);
    } catch(e) {
      //ignore error
    }
 });
}
