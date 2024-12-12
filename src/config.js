const flR = require('../src/util/flR.js');

const config = {
    gamePath: './game',
    configFile: './config.json',
    emulatorsFile: './data/setup/emulators.json',
    genresFile: './data/setup/genres.json',
    platformsFile: './data/setup/platforms.json',
    yearsFile: './data/setup/years.json',
    finalFile: './data/output/final.json'
};

// Read settings from the user config file
const configData = JSON.parse(flR.read(config.configFile) || '{}');
if (configData.path) {
    config.gamePath = configData.path;
}

module.exports = config;
