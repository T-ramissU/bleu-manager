var url = "https://bleusaille.emixam.be/google_form.php";
var options =
  {
    "method" : "POST",
    "payload" : data, 
    "followRedirects" : false,
    "muteHttpExceptions": false
  };

function onFormSubmit(form) {  
  var data =
  {
    "nom" : form.namedValues['Nom'][0],
    "prenom" : formnamedValues['Prénom'][0],
    "sexe": formnamedValues['Genre'][0],
    "adresse": formnamedValues['Adresse'][0],
    "daten": formnamedValues['Date de naissance'][0],
    "regio": formnamedValues['Régionale'][0],
    "resplegal": formnamedValues['Nom du responsable légal'][0] + ' ' + formnamedValues['Prénom du responsable légal'],
    'numresplegal':formnamedValues['Numéro de téléphone du responsable légal'][0],
    "tel" : formnamedValues['Numéro de téléphone'][0], 
  };
    
  UrlFetchApp.fetch(url, options);
}

function sendAll() {
  var sheet = SpreadsheetApp.getActive().getSheetByName("Réponses au formulaire 1");
  var table = sheet.getDataRange().getValues();

  table.forEach(function (row) {    
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

    try {
      UrlFetchApp.fetch(url, options);
    } catch(e) {
      //ignore error
    }
 });
}