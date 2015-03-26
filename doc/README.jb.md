* Need to add a 'search_address' parameter 
* Consider passing data e.g. 'yelp_tag':
  `under-the-table-restaurant-toronto`
  `seven-lives-tacos-y-mariscos-toronto`

  Can use this just for debugging, even as a strong search clue, and eventually maintain a slugs table

* Biggest problem is fuzzy matching restaurant name vs address.
  * One way to solve this could be:

    getFuzzyMatch(source, slug, name, address) {
      if (resto = getExactSlugMatch(source,slug)) {
        return resto;        
      }

      addressMatches = searchByAddress(address);
      if (addressMatches.length == 1) {
        return addressMatches.first;
      }
      
      restoMatches = searchByRest(resto);
      if (restoMatches.length == 1) {
        return restoMatches.first;
      }

      potentials = Array.merge(addressMatches, restoMatches);
      redirect(resto_picker, potentials, source, slug)

    }

    resto_picker(potentials, source, slug) {
      selected = show_user_select_list(potentials);
      
      updateSlugHint(selected, source, slug)


    }

  