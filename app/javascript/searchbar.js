window.searchFunction = function() {
  let input = document.getElementById('searchInput');
  let filter = input.value.toUpperCase();
  let p = document.getElementsByTagName('p');

  for (i = 0; i < p.length; i++) {
    let txtValue = p[i].textContent || p[i].innerText;
    if (txtValue.toUpperCase().indexOf(filter) > -1) {
      p[i].scrollIntoView();
      break;
    }
  }
}
