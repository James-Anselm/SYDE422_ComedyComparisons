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


var youData = new Array();

//var url = "https://www.googleapis.com/youtube/v3/videos?id=7lCDEYXw3mM&key=AIzaSyB5D-SzrHae0MBPJl65RLZ2pyXDG6am_8A%20&part=snippet,contentDetails,statistics,status";


var url_1 = "https://www.googleapis.com/youtube/v3/videos?id=";
var url_2 = "&key=AIzaSyB5D-SzrHae0MBPJl65RLZ2pyXDG6am_8A%20&part=snippet,contentDetails,statistics,status";

var url;

function getYoutubeData() {
  for(var i=20000; i<21000; i++){
    url = url_1 + ids[i] + url_2;
    $.getJSON(url,
      function(response){
          //title = response.data.items[0].title;
          //description = response.data.items[0].description;
         youData.push(response);
        // $("#response").text(recMap(response));
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
