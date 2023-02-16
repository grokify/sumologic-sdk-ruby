Sumo Logic Ruby SDK
===================

[![Gem Version][gem-version-svg]][gem-version-link]
[![Build Status][build-status-svg]][build-status-link]
[![Dependency Status][dependency-status-svg]][dependency-status-link]
[![Codacy Badge][codacy-svg]][codacy-link]
[![Code Climate][codeclimate-status-svg]][codeclimate-status-link]
[![Scrutinizer Code Quality][scrutinizer-status-svg]][scrutinizer-status-link]
[![Docs][docs-rubydoc-svg]][docs-rubydoc-link]
[![License][license-svg]][license-link]

[![Stories in Ready][story-status-svg]][story-status-link]

Ruby interface to the Sumo Logic REST API.

## Usage

The Ruby SDK is ported from the [Sumo Logic Python SDK](https://github.com/SumoLogic/sumologic-python-sdk).

The following methods are currently implemented:

```ruby
sumo = SumoLogic::Client.new access_id, access_key

# Search
r = sumo.search query [, from, to, time_zone]

r = sumo.search_job query [, from, to, time_zone]

r = sumo.search_job_messages {'id' => search_job_id}, limit, offset

r = sumo.search_job_records {'id' => search_job_id}, limit, offset

r = sumo.search_job_status {'id' => search_job_id}

# Dashboards
r = sumo.dashboards

r = sumo.dashboard dashboard_id

r = sumo.dashboard_data dashboard_id

# Collectors
r = sumo.collectors [limit, offset]

r = sumo.collector collector_id

r = sumo.update_collector collector, etag

r = sumo.delete_collector collector

# Sources
r = sumo.sources collector_id [, limit, offset]

r = sumo.source collector_id, source_id

r = sumo.update_source collector_id, source, etag

r = sumo.delete_source collector_id, source

# Content
r = sumo.create_content path, data

r = sumo.get_content path

r = sumo.delete_content path
```

Note, for the search methods, the query parameter can be exactly the same query that is entered into the Sumo Logic web console.

Example scripts are located in the `scripts` directory of the [GitHub repo](https://github.com/grokify/sumologic-sdk-ruby).

## Change Log

See [CHANGELOG.md](CHANGELOG.md).

## Links

Project Repo

* https://github.com/grokify/sumologic-sdk-ruby

Sumo Logic API Documentation

* https://help.sumologic.com/APIs
* https://github.com/SumoLogic/sumo-api-doc/wiki

Sumo Logic Python SDK

* https://github.com/SumoLogic/sumologic-python-sdk

## Contributions

Please add your scripts and programs to the `scripts` folder.

Any reports of problems, comments or suggestions are most welcome.

Please report these on [Github](https://github.com/grokify/sumologic-sdk-ruby)

## License

Sumo Logic Ruby SDK is available under an MIT-style license. See [LICENSE.md](LICENSE.md) for details.

Sumo Logic Ruby SDK &copy; 2015-2023 by John Wang

 [gem-version-svg]: https://badge.fury.io/rb/sumologic.svg
 [gem-version-link]: http://badge.fury.io/rb/sumologic
 [downloads-svg]: http://ruby-gem-downloads-badge.herokuapp.com/sumologic
 [downloads-link]: https://rubygems.org/gems/sumologic
 [build-status-svg]: https://api.travis-ci.org/grokify/sumologic-sdk-ruby.svg?branch=master
 [build-status-link]: https://travis-ci.org/grokify/sumologic-sdk-ruby
 [dependency-status-svg]: https://gemnasium.com/grokify/sumologic-sdk-ruby.svg
 [dependency-status-link]: https://gemnasium.com/grokify/sumologic-sdk-ruby
 [codacy-svg]: https://api.codacy.com/project/badge/Grade/d6c7f184a9394629a9a65a1406e9f767
 [codacy-link]: https://www.codacy.com/app/grokify/sumologic-sdk-ruby
 [codeclimate-status-svg]: https://codeclimate.com/github/grokify/sumologic-sdk-ruby/badges/gpa.svg
 [codeclimate-status-link]: https://codeclimate.com/github/grokify/sumologic-sdk-ruby
 [scrutinizer-status-svg]: https://scrutinizer-ci.com/g/grokify/sumologic-sdk-ruby/badges/quality-score.png?b=master
 [scrutinizer-status-link]: https://scrutinizer-ci.com/g/grokify/sumologic-sdk-ruby/?branch=master
 [story-status-svg]: https://badge.waffle.io/grokify/sumologic-sdk-ruby.svg?label=ready&title=Ready
 [story-status-link]: https://waffle.io/grokify/sumologic-sdk-ruby
 [docs-rubydoc-svg]: https://img.shields.io/badge/docs-rubydoc-blue.svg
 [docs-rubydoc-link]: http://www.rubydoc.info/gems/sumologic/
 [license-svg]: https://img.shields.io/badge/license-MIT-blue.svg
 [license-link]: https://github.com/grokify/sumologic-sdk-ruby/blob/master/LICENSE.txt
