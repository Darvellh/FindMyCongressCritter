# FindMyCongressCritter
Find your Senator and/or Representative from last name, state, or zip code.
By Darvell Hunt

This app implements the API located at whoismyrepresentative.com/api. I implemented search by
last name, by state, and by zip code. The search panel uses a smart-sense algorthym that allows
entering of any of the search options.

If you search by enterintg a last name, you get results including all senators and
representatives with that last name. If you search by entering a 2-letter state abbreviation,
you get all senators ans representatives for that state. If you search by zip code, you get
the senators for that state, plus the representative for that zip code.

All results, including muliples, are added individually to a table view list. Each senator
or representative can be selected to go to a detail page to display all of the data received,
which include: Summary, in the exmaple of: Mia Love (R) UT, name, party, state, district,
phone, office location, and website link.

iPads and iPhone 6 Plus have a split display which show the search panel and the detail view
at the same time. New senators and/or representatives can be added to the list at anytime using
the search panel. Items can be deleted from the list by swiping or using the EDIT button.

Additional features that I didn't get to, but wanted to, were searching separately by senator
or representitive, by adding a keywords "sen" or "senator" or "rep" or "represetnative" along
with the name. I did add the EDIT button to be able to delete names form the table view, but I
would like to add a CLEAR button to delete them all. I would also liked to have added a check
to see if a name already existed in the list before adding it again.

I also would like to add error alerts for when no data was returned, or other errors that
occur. Right now the app doesn't crash from them, but the user is not alerted.

I made the app more efficient by calling both the senator API and the representative API for
searching last names and states. The smart-sense search panel also allows just ONE search
panel for conducting all types of searches. This improved the interface by simplifying its
appearance as well as simplifying its use. Adding the ability to use keywords would keep this
simplicity, but add power and flexibility.

The features that pleased me the most were the simple smart interface, and the ability
to have multiple senators and reprsentatives in the list at any given time. I also liked
that I could make two API calls for a single search to get both senator and representative
data. Also, on larger devices, the search results can also be displayed at the same time
as the detail page.
