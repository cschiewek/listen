// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".
import socket from "./socket"

// POST to /api/play
$("#play-url").on("click", () => {
  let apiUrl = $("#play_url").data("api-url")
  let playUrl = $("#play_url").val()
  $.post(apiUrl, { url: playUrl })
})

$("#play-file").on("click", () => {
  let apiUrl = $("#play_file").data("api-url")
  let file = $("#play_file")[0].files[0]
  let data = new FormData()
  data.append('file', file)

  $.post({
    url: apiUrl,
    processData: false,
    contentType: false,
    data: data
  })
})

// Listen on channel and play
let channel = socket.channel("broadcast", {})
channel.on("play", payload => {
  audio.src = payload.src
  audio.name = payload.name
  audio.play()
})

// Setup audio object
let audio = new Audio

audio.onplay = function() {
  $("#nothing").hide()
  $("#now-playing").html(audio.name)
}

audio.onended = function() {
  $("#now-playing").html("")
  $("#nothing").show()
}
