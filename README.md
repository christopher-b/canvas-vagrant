Canvas Vagrant
==============

A [Vagrant](http://www.vagrantup.com/) + [Puppet](https://puppetlabs.com/) script for installing [Canvas LMS](https://github.com/instructure/canvas-lms)

Run it:

```
git clone https://github.com/christopher-b/canvas-vagrant.git
cd canvas-vagrant
git submodule init
git submodule update
vagrant up
```

Now go grab a beer, this will take a few minutes. When it's done:

```
vagrant ssh
sudo su
cd /vagrant/canvas
RAILS_ENV={production|development|test} bundle exec rake db:initial_setup
```

Then load https://canvas-lms.dev:4443.

Canvas is cloned into the shared vagrant folder, as `./canvas`.


## Known Issues / Todo
 - The init script may try to start before the code is checked out
 - No Redis
 - No mail
 - No QTI Migrations