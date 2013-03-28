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
  'buttscratcher'
];

function findFunnyWordsInString(string) {
  var funnyWordsConcat = funnyWords.join('|');
  var regex = new RegExp(funnyWordsConcat, "gi");
  var match = string.match(regex);
  return match ? match.length : 0;
}

function printYoutubeData() {
  document.body.innerHTML = '';
  for (var data in youData) {
    if (youData[data].items[0] != undefined) {
      var id = youData[data].items[0].id;
      var statistics = youData[data].items[0].statistics;
      var funnyWords =
        findFunnyWordsInString(youData[data].items[0].snippet.description);

      document.write(id + ',' +
                     statistics.commentCount + ',' +
                     statistics.dislikeCount + ',' +
                     statistics.favoriteCount + ',' +
                     statistics.likeCount + ',' +
                     statistics.viewCount + ',' +
                     funnyWords + '<br>');
    }
  }
}


var youData = new Array();

//var url = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyB5D-SzrHae0MBPJl65RLZ2pyXDG6am_8A%20&part=snippet,contentDetails,statistics,status";


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
          //title = response.data.items[0].title;
          //description = response.data.items[0].description;
        youData.push(response);
        // $("#response").text(recMap(response));

        document.body.innerHTML = '';
        document.write("Loading... " + completeCount + "/" + queryCount);

        if (++completeCount == queryCount) {
          printYoutubeData();
        }
      }
   );
  }
}


/*$.getJSON(url,
    function(response){
        //title = response.data.items[0].title;
        //description = response.data.items[0].description;
        youData.push(response);
        $("#response").text(recMap(response));
});*/

var recMap = function(obj) {
    return $.map(obj, function(val, ind) { 
        return typeof val !== 'object' 
               ? '"' + ind + '":"' + val + '"' : recMap(val);
    });
}
