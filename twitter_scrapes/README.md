# Twitter Scrapes
Using selenium to get around the API limits.

## How to run:
Using **Python 3.8**. You will also need Firefox and the geckodriver. On MacOS it can be installed with `brew install geckodriver`.

1. `virtualenv venv`
2. `pip install -r requirements.txt`
3. `jupyter-lab`



Once jupyter opens in your browser, you can open `twitter_functions.ipynb` to run the code.

- `Twitter(username, password)` is a class that creates a selenium driver and logs into twitter.
- `User(users_tag, twitter)` is a class that creates an instance of a twitter user. It will need an instance of the Twitter class to function as it should.
- `user_instance.scrape_followers()` will open twitter and put the twitter followers into a `Set()`; this set can be accessed by `user_instance.followers`

### Example:
- `random_person = User("MCGPetch", twitter)`
- `random_person.followers`

You can get the intersectin of two sets of followers:

`p1.followers.intersection(p2.followers)`

