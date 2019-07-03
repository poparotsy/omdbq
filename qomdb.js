const https = require("https");
const url = process.env.omdbUrl || "https://www.omdbapi.com/?i=tt3896198&apikey=7eff34ec&t=";
const movie = process.env.movie || "";

var query = url + movie.replace(" ", "+");

//console.log(process.env.omdbUrl);
//console.log(process.env.movie);
//console.log(query);

https
  .get(query, res => {
    let body = "";
    res.on("data", data => {
      body += data;
    });
    res.on("end", () => console.log(JSON.parse(body)));
  })
  .on("error", error => console.error(error.message));
