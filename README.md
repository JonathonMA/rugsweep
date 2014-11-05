# Rugsweep

Sweeps files under the rug.

## Installation

Install it using rubygems:

    $ gem install rugsweep

## Usage

Create a configuration file: *not implemented yet*

    $ rugsweep init --rug=tmp GoodFile1 GoodFile2

Now you can sweep things under the rug:

    $ ls
    GoodFile1
    GoodFile2
    BadFile
    BadFile2

    $ rugsweep
    (M) BadFile
    (M) BadFile2

    $ ls
    GoodFile1
    GoodFile2

    $ ls tmp
    BadFile
    BadFile2

You can mark additional "good" files using ok *not implemented yet*

    $ rugsweep ok GoodFile3

## TODO

1. init
2. ok

## Contributing

1. Fork it ( https://github.com/JonathonMA/rugsweep/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
