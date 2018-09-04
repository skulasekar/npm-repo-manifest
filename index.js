'use strict';

var fs = require('fs'),
    path = require('path'),
    xmlReader = require('read-xml'),
    parseString = require('xml2js').parseString;

var FILE = path.join(__dirname, 'manifest.xml');

var original_git_urls = []
var new_git_urls = []
var new_remote = "https://github.com/cablelabs/"

function process(err, data) {
  parseString(data.content, function (err, result) {
    // console.dir(result)
    var remotes = result["manifest"]["remote"]
    var remote_names = remotes.map(b => b.$.name)
    var fetches = remotes.map(b => b.$.fetch)
    var default_remote_name = result["manifest"]["default"].map(a => a.$.remote)
    var projects = result["manifest"]["project"]
    // console.dir(default_remote);

    projects.forEach(function(item) {
      var project_name = item.$.name
      var remote = item.$.remote
      var orig_git_url = ""

      if(remote != undefined)
          orig_git_url += fetches[remote_names.indexOf(remote)]
      else
          orig_git_url += fetches[remote_names.indexOf(default_remote_name[0])]

      // Add the project name to the fetch url
      orig_git_url += orig_git_url.charAt(orig_git_url.length - 1) == '/' ? project_name : "/" + project_name
      orig_git_url += ".git"
      original_git_urls.push(orig_git_url);

      // Add the new git url for creation
      var new_project_name = project_name.split('/').pop()
      new_git_urls.push(new_remote + (new_remote.charAt(new_remote.length - 1) == '/' ? new_project_name : "/" + new_project_name) + ".git")
    })
  });

  console.dir(original_git_urls)
  console.dir(new_git_urls)
}

// pass a buffer or a path to a xml file
xmlReader.readXML(fs.readFileSync(FILE), process);

exports.read = function(filename, callback) {
  console.log("This is a message from the demo package");

}
