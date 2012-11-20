Getting Started
===============

The quickest way to get started using AppScale Tools is using VirtualBox and
Vagrant.

Installing VirtualBox
---------------------

Please visit the `VirtualBox website`__ for more details.

Installing Vagrant
------------------

Make sure you have Ruby and Rubygems support.  Then, from the command line, run::

    gem install vagrant

Launching a development VM
--------------------------

Once the prerequisites are installed, simply run ``vagrant up`` to setup the
environment, followed by ``vagrant ssh`` to connect to the VM.  The repository
is mounted inside the VM at ``/home/vagrant/appscale/appscale-tools``.

Configure credentials
---------------------

Vagrant will automatically create and share the ``~/.appscale-tools``
configuration directory with the VM so that it has access to your EC2
credentials.  Create the file ``~/.sppscale-tools/appscale_config.sh`` with the
following content (filling in your personal information, of course)::

    export EC2_ACCESS_KEY='{{ your key here }}'
    export EC2_SECRET_KEY='{{ your key here }}'
    export EC2_USER_ID='{{ your id here }}'

Next, copy the AWS certificate and private key to
``~/.appscale-tools/cert.pem`` and ``~/.appscale-tools/pk.pem`` respectively.

Once you SSH into the VM (``vagrant ssh``), confirm your personal
information is displayed when using the command::

    echo $EC2_ACCESS_KEY

If you are already logged into the system, you may have to logout and back in.
Alternatively, you can manually source the file using the command ``source
~/.appscale-tools/appscale_config.sh``

.. _VirtualBox: http://virtualbox.org/
__ VirtualBox_
