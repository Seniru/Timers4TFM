const fs = require('fs');
const luamin = require('luamin');

let code = '';

function minifiy(code) {
    console.log('Minifying script...');

    fs.writeFile("timer.min.lua", luamin.minify(code) + ";Timer=a\n", (err) => {
        if (err) error(err);
    });
}

console.log('Reading timer.lua...');

fs.readFile("timer.lua", "utf-8", (err, data) => {
    code = data;
    minifiy(code);
    console.log("Successfully Written to File.");
})

