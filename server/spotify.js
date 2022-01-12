const querystring = require("querystring");
const express = require("express");
const request = require("request");
var app = express();

var client_id = "04ae1192f5524805baa90fbe9b6f43cb";
var client_secret = "549da1c4b92f4c638128628e10b40153";
var redirect_uri = "http://localhost:3000/callback";

app.get("/login", function (req, res) {
    var state = "7";
    var scope = "user-read-private user-read-email user-top-read";

    res.redirect(
        "https://accounts.spotify.com/authorize?" +
            querystring.stringify({
                response_type: "code",
                client_id: client_id,
                scope: scope,
                redirect_uri: redirect_uri,
                state: state,
            })
    );
});

var code =
    "AQCCHNNAJ9CzCopU7AAo9fkXu6429mWLXjY7dH5cLNP-_wRARr6bdoUyeHce1FttphMZeh_Veq5zoTahuD5PbnSCqR9oNdPjCJj1X_tz6FxBmzoAPHEeazjumNdmF_hRxYlRWKUoCx6lBMS6zXr36Ym6-ZMZK545ahO5jGikYeouhna3EZ0aiDT0rEewpXB3ZflMVVmLN4_yJ9h0t275u1bvYNQu_6Fo7QExUYDzqtUevH-W0Q";
var c2 =
    "AQArIgkvIMQwiGhSxnEEVfDxAnJhSHzW2ghTyKAzN2WJq1790qIJ8DLpXmooarYsmoyR9MXOOmr2er7l52If0Tf6RXcnEknXSovC6HJC-gOH9HBSE7j2b0SIBtRgxlQV5Xyoq6BVUFGtCrY96qH9CPCkrdc653zP";
var refresh_token =
    "AQAEeNZluzj_SKmfHIzBcnQNIFAqbcpKEQSuwhLtFYS8qGTtsr-Qyyx7TK0paLfl8WCw9KpbwDT-3srGp5I73sIlo4_oWnFEKiG0K_1vOHVmDjstuhBtrv3JUs8XFwHBbkg";
var access =
    "BQDI-pflx_wO4UHRZ7r7UbCwbuBmtgh5hT_Wpf77mXlEkmxCZK69upJXXBpu5vCc3Gw4Ygmctn5SxnmcymjdNuDN56xP5cGRjpSG9nM8aHfzVeGvB4fjPa65wNPWBl_3Yd7bLoHTvbnH4pUZLYDEI_1RXWLw_7IMfAL153pfYYzIf6mDQhVe0O2XN_c";
var ds =
    "AQBnp4WGSuUApfAnTpU_E00JHY1mMFWzHVMBIyk6dNlFFVSiWdUGfM_DXmq1q7xBoWWEI9XofoasVoK7HOIE9VxoH9gn28gz5omeHSxsUQ5leapa6rYkGgDW1CnOwLsed4mkCA3fgYeWFz9AxWhPtLH7Vea7VSbcJ1hHZF-jzg3NB8mq90BPXgXF92puYTZBUzPhdtstfT7f0EX8A7yMZnL_1lu5jsA0H7rw3jI4FKBXc9ADxA";
app.get("/callback", function (req, res) {
    console.log(code);
    var code = c2;
    var state = 7;
    if (state === null) {
        res.redirect(
            "/#" +
                querystring.stringify({
                    error: "state_mismatch",
                })
        );
    } else {
        var authOptions = {
            url: "https://accounts.spotify.com/api/token",
            form: {
                code: c2,
                redirect_uri: redirect_uri,
                grant_type: "authorization_code",
            },
            headers: {
                Authorization:
                    "Basic " +
                    new Buffer(client_id + ":" + client_secret).toString(
                        "base64"
                    ),
            },
            json: true,
        };
        request.post(authOptions, (req, res, body) => {
            console.log(res.data);
            console.log(body);
        });
    }
});
app.get("/refresh_token", function (req, res) {
    var authOptions = {
        url: "https://accounts.spotify.com/api/token",
        headers: {
            Authorization:
                "Basic " +
                new Buffer(client_id + ":" + client_secret).toString("base64"),
        },
        form: {
            grant_type: "refresh_token",
            refresh_token: refresh_token,
        },
        json: true,
    };

    request.post(authOptions, function (error, response, body) {
        if (!error && response.statusCode === 200) {
            var access_token = body.access_token;
            res.send({
                access_token: access_token,
            });
        }
    });
});
app.listen(3000, () => {
    console.log("server running");
});
