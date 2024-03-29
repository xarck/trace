const express = require("express");
const request = require("request");
const keys = require("./config.js");

var app = express();

app.get("/login", function (req, res) {
    var scope = "user-read-private user-read-email user-top-read";
    let urlString = new URLSearchParams({
        response_type: "code",
        client_id: keys.client_id,
        scope: scope,
        redirect_uri: keys.redirect_uri,
    });
    res.redirect(
        "https://accounts.spotify.com/authorize?" + urlString.toString()
    );
});

app.get("/callback", function (req, res) {
    var code = req.query.code || null;
    var authOptions = {
        url: "https://accounts.spotify.com/api/token",
        form: {
            code: code,
            redirect_uri: keys.redirect_uri,
            grant_type: "authorization_code",
        },
        headers: {
            Authorization:
                "Basic " +
                new Buffer(keys.client_id + ":" + keys.client_secret).toString(
                    "base64"
                ),
        },
        json: true,
    };
    request.post(authOptions, (req, _, body) => {
        res.json(body);
    });
});
app.get("/refresh_token", function (req, res) {
    var authOptions = {
        url: "https://accounts.spotify.com/api/token",
        headers: {
            Authorization:
                "Basic " +
                new Buffer(keys.client_id + ":" + keys.client_secret).toString(
                    "base64"
                ),
        },
        form: {
            grant_type: "refresh_token",
            refresh_token: req.query.refresh_token,
        },
        json: true,
    };

    request.post(authOptions, function (error, response, body) {
        if (!error && response.statusCode === 200) {
            var access_token = body.access_token;
            res.json({
                access_token: access_token,
            });
        }
    });
});

app.listen(3000, () => {
    console.log("server running");
});
