var txtFile = new XMLHttpRequest();
var ids;
txtFile.open("GET", "comedy_comparisons_videos.txt", true);
txtFile.onreadystatechange = function()
{
  if (txtFile.readyState === 4) {  // document is ready to parse.
    if (txtFile.status === 200) {  // file is found
      allText = txtFile.responseText; 
      ids = txtFile.responseText.split("\n");
      getYoutubeData();
    }
  }
}
txtFile.send(null);

var funnyWords = [
  'funny',
  'lol',
  'views',
  'likes',
  'cat',
  'kitten',
  'dog',
  'puppy',
  'booger',
  'baboon',
  'sombrero',
  'hamster',
  'gerbil',
  'toilet',
  'fart',
  'cabbage',
  'booby',
  'buttscratcher',
  'ninja'
];

function findFunnyWordsInString(string) {
  var funnyWordsConcat = funnyWords.join('|');
  var regex = new RegExp(funnyWordsConcat, "gi");
  var match = string.match(regex);
  return match ? match.length : 0;
}

var delimiter = ' ';
function printYoutubeData() {
  // Stores the complete data that we're going to save.
  var completeDataString = '';

  for (var data in youData) {
    if (youData[data].items[0] != undefined) {
      var id = youData[data].items[0].id;
      var statistics = youData[data].items[0].statistics;
      var funnyWordsInTitle =
        findFunnyWordsInString(youData[data].items[0].snippet.title);
      var funnyWordsInDesc =
        findFunnyWordsInString(youData[data].items[0].snippet.description);

      var dataString = '"' + id + '"' + delimiter +
                       statistics.commentCount + delimiter +
                       statistics.dislikeCount + delimiter +
                       statistics.favoriteCount + delimiter +
                       statistics.likeCount + delimiter +
                       statistics.viewCount + delimiter +
                       funnyWordsInTitle + delimiter +
                       funnyWordsInDesc + '\n';

      completeDataString += dataString;

      document.write(dataString.replace('\n', '<br>'));
    }
  }

  window.open('data:text/csv;charset=utf-8,' + escape(completeDataString));
}

var youData = new Array();

var url_1 = "https://www.googleapis.com/youtube/v3/videos?id=";
var url_2 = "&key=AIzaSyB5D-SzrHae0MBPJl65RLZ2pyXDG6am_8A%20&part=snippet,contentDetails,statistics,status";

var url;

var startId = 20000;
var endId = 21000;
var queryCount = endId - startId;
var completeCount = 0;

function getYoutubeData() {
  for(var i=startId; i<endId; i++){
    url = url_1 + ids[i] + url_2;
    $.getJSON(url,
      function(response){
        youData.push(response);

        document.body.innerHTML = '';

        if (++completeCount == queryCount) {
          printYoutubeData();
        } else {
          document.write("Loading... " + completeCount + "/" + queryCount + "<br>");
        }
      }
   );
  }
}

var recMap = function(obj) {
    return $.map(obj, function(val, ind) { 
        return typeof val !== 'object' 
               ? '"' + ind + '":"' + val + '"' : recMap(val);
    });
}
