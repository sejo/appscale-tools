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

Downloading the base box
~~~~~~~~~~~~~~~~~~~~~~~~

Vagrant uses a base box to create VMs.  Run the command below to download an
Ubuntu 10.04 Lucid 64-bit box::

    vagrant box add lucid64 http://files.vagrantup.com/lucid64.box

Clone the AppScale Tools repository
-----------------------------------

Vagrant is configured to automatically mount ``~/Appscale`` as
``/srv/appscale`` on the VM, and look for the ``appscale-tools`` repo at
``/srv/appscale/repo/appscale-tools``.  At the moment there are some
limitations with the Puppet manifest script that require hard-coded absolute
paths.

Clone the repository in ``~/Appscale/repo`` on your computer::

    mkdir -p ~/Appscale/repo
    cd ~/Appscale/repo
    git clone https://github.com/AppScale/appscale-tools.git
    cd appscale-tools

Currently this documentation reflects the changes in the
``auto_appscale_install`` branch, so switch to that branch::

    git checkout auto_appscale_install

Launching a development VM
--------------------------

Once the prerequisites are installed, simply run ``vagrant up`` to setup the
environment, followed by ``vagrant ssh`` to connect to the VM.  The repository
is mounted inside the VM at ``/srv/appscale/repo/appscale-tools``.

The ``repo`` command
~~~~~~~~~~~~~~~~~~~~

AppScale Tools includes a ``repo`` command which makes it easy to switch to
repositories.  Type ``repo`` and double tab to see a list of repositories in
the ``/srv/appscale/repo`` directory.

Configure credentials
---------------------

Vagrant will automatically create and share the ``~/.appscale-tools``
configuration directory with the VM so that it has access to your EC2
credentials.  Create the file ``~/.appscale-tools/appscale_config.sh`` with the
following content (filling in your personal information, of course.  Do not
include curly braces)::

    export EC2_ACCESS_KEY='{{ your key here }}'
    export EC2_SECRET_KEY='{{ your key here }}'
    export EC2_USER_ID='{{ your id here }}'

Download AWS Credentials
------------------------

Download your account's certificate and private key or ask your administrator
for IAM credentials.

Next, copy the AWS certificate and private key::

    cp <path to cert-*.pem> ~/.appscale-tools/cert.pem
    cp <path to pk-*.pem> ~/.appscale-tools/pk.pem

Once you SSH into the VM (``vagrant ssh``), confirm your personal
information is displayed when using the command::

    echo $EC2_ACCESS_KEY

If you are already logged into the system, you may have to logout and back in.
Alternatively, you can manually source the file using the command ``source
~/.appscale-tools/appscale_config.sh``

Confirm EC2 Tools are working
-----------------------------

Confirm EC2 Tools are working by running the command::

    ec2-describe-instances

Create an EC2 SSH key
---------------------

With a working EC2 environment, you can create an SSH key that will be used to
SSH into any EC2 instances created.  Run the following command substituting
your name below::

    ec2-add-keypair <your name> >> ~/.appscale-tools/id_<your name>

For example::

    ec2-add-keypair berto >> ~/.appscale-tools/id_berto

Now, update ``~/.appscale-tools/appscale_config.sh`` with the following entry::

    export EC2_MY_SSH_KEY=~/.appscale-tools/id_<your nae>

Your system is now configured!  Note that even if you destroy this VM, you will
not need to re-configure the system.  These configuration files are kept in
your host machine's home directory under ``~/.appscale-tools``.  You can run
``vagrant destroy``, followed by ``vagrant up`` and you'll be ready to run
instantly.

.. _VirtualBox: http://virtualbox.org/
__ VirtualBox_
