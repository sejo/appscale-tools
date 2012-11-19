Getting Started
===============

The quickest way to get started developing AppScale Tools is using VirtualBox
and Vagrant.

Installing VirtualBox
---------------------

Please visit the VirtualBox_ website for more details.

Installing Vagrant
------------------

Make sure you have Ruby and Rubygems support.  Then, from the command line, run::

    gem install vagrant

.. _VirtualBox: http://virtualbox.org/

Launching a development VM
--------------------------

Once the prerequisites are installed, simply run ``vagrant up`` to setup the
environment, followed by ``vagrant ssh`` to connect to the VM.  The repository
is mounted inside the VM at ``/home/vagrant/appscale/appscale-tools``.
