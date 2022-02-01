$(document).on('turbolinks:load', function () {
  const links = document.querySelectorAll("a[data-remote]");
  links.forEach((element) => {
    element.addEventListener("ajax:success", (event) => {
      const [_data, _status, json] = event.detail;
      alert(json.responseText);
    });
  });
});
