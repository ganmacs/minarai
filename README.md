# Minarai
[![Build Status](https://travis-ci.org/ganmacs/minarai.svg?branch=master)](https://travis-ci.org/ganmacs/minarai)
[![Code Climate](https://codeclimate.com/github/ganmacs/minarai/badges/gpa.svg)](https://codeclimate.com/github/ganmacs/minarai)

Configuration-Management Tool

## Installation

```sh
$ gem install minarai
```

## Getting Started

Create a recipe file as `recipe.yml`


```ruby
- name: brew install peco
  type: homebrew
  item: peco

- name: brew install jq
  type: homebrew
  item: jq
```

And then excute `minarai` command to apply a recipe

```
$ minarai recipe.yml
INFO : Minarai starting...
INFO : [DONE] brew install peco
INFO : [DONE] brew install jq
INFO : Minarai finish
```

## Usage

```sh
$ minarai RECIPE [--variable=VARIABLE_PATH]
```

## Action type

* hoembrew
* directory
* file
* git
* hoembrew_cask
* link
* url_get

## recipe

https://github.com/ganmacs/minarai/tree/master/examples

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
