$(document).on('turbolinks:load', function() {
  document.getElementById('overseas-fields').classList.add('hidden')
  document.getElementById('officers-fields').classList.add('hidden')
  $('#overseas').change(function() {
    if (this.checked) {
      document.getElementById('overseas-fields').classList.remove('hidden')
      }
    else {
      document.getElementById('overseas-fields').classList.add('hidden')
    }
  });

  $('#officer').change(function() {
    if (this.checked) {
      document.getElementById('officers-fields').classList.remove('hidden')
      }
    else  {
      document.getElementById('officers-fields').classList.add('hidden')
    }
  });
})
