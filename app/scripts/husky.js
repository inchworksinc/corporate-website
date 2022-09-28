var exec = require('child_process').exec;
var os = require('os');


module.exports.prepareHusky = () => {
// Run command depending on the OS
if (os.type() === 'Windows_NT') 
   /**
    * This command does the following
    * 1. Changes directory to the root
    * 2. Removes husky folder if its exists
    * 3. Re-installs husky
    * 4. Adds a precommit hook for
    *    4.1 Linting the code
    *    4.2 Running the unit tests
    **/ 
   exec("cd .. && rmdir /s /q .husky && npx husky install && npx husky add .husky/pre-commit \"cd app && npm run lint && npm test\"");
else
   /**
    * This command does the following
    * 1. Changes directory to the root
    * 2. Removes husky folder if its exists
    * 3. Re-installs husky
    * 4. Adds a precommit hook for
    *    4.1 Adding /usr/loca/bin to PATH and exporting it. This is needed for the precommit hook to work when using git functionality directly from the IDE in OS's other than Windows.
    *    4.2 Linting the code
    *    4.3 Running Unit tests
    **/ 
   exec("cd .. && rm -rf .husky && npx husky install && npx husky add .husky/pre-commit \"export PATH=\"/usr/local/bin/:$PATH\" && cd app && npm run lint && npm test\""); 
}


