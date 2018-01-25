# sel-hub-dl-trouble
## Why?
Created to demonstrate a feature discrepancy between the use of:

* [selenium/standalone-chrome](https://hub.docker.com/r/selenium/standalone-chrome)
* and the combination of:
    *  [selenium/hub](https://hub.docker.com/r/selenium/hub/)
    *  [selenium/standalone-chrome](https://hub.docker.com/r/selenium/standalone-chrome)


## Execution steps

## Option_1 (noisy)

Execute the following from the root of your cloned copy of this repo:

    docker-compose up

From there you can watch until the logs from the `ruby` container appear.

## Option_2
Execute the following from the root of your cloned copy of this repo:

    docker-compose up -d
    docker-compose logs -f ruby

## Sample output
At the time of creation, [Option 2](#Option_2) gave this output:

    Attaching to selhubdltrouble_ruby_1
    ruby_1                 |  ==== Testing with GRID driver: ====
    ruby_1                 | Files found in tmp dir:
    ruby_1                 | .
    ruby_1                 | ..
    ruby_1                 | test-dl.csv
    ruby_1                 | ERROR: Download directory was not created automatically by chrome
    ruby_1                 | ================== END ==================
    ruby_1                 |  ==== Testing with STANDALONE driver: ====
    ruby_1                 | Files found in tmp dir:
    ruby_1                 | .
    ruby_1                 | ..
    ruby_1                 | a7d63c381378
    ruby_1                 | test-dl.csv
    ruby_1                 | Files found in the download directory:
    ruby_1                 | .
    ruby_1                 | ..
    ruby_1                 | test-dl.csv
    ruby_1                 | >>>>>>>>>>>
    ruby_1                 | DOWNLOADED FILE CONTENTS:
    ruby_1                 |  id,name,quote
    ruby_1                 |
    ruby_1                 | 1,Strong Bad,The ladies will be all upons!
    ruby_1                 |
    ruby_1                 | 2,Frodo Baggins,The ring will be safe in Rivendell.
    ruby_1                 |
    ruby_1                 | 3,Harry Potter,There's no need to call me "sir" Professor.
    ruby_1                 |
    ruby_1                 | 4,Luke Skywalker,But I was going into Tosche Station to pick up some power converters!
    ruby_1                 |
    ruby_1                 | 5,Willy Wonka,There see. Completely unharmed.
    ruby_1                 |
    ruby_1                 |
    ruby_1                 | <<<<<<<<<<<
    ruby_1                 | ================== END ==================
    selhubdltrouble_ruby_1 exited with code 0

