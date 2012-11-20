First Run
=========

Create the AWS credentials file (get from Tyler)

Source the AWS credentials file

cd /root

Check that ``ec2-describe-instances`` works.  This means AppScale will work.

``appscale-run-instances`` [with flags] - fires up a cloud


6.5 G with code

Installs all NoSQL packages


    ec2-run-instances -t m1.large -n 1 -k mykeyname ami-67b202ae
    ec2-describe-instances | grep mykeyname


Take a snapshot and make a personal AMI::

    ec2-create-image -n cjkASAMI i-ID

    # to see the status (pending -> available)
    ec2-describe-images -o self

    ec2-terminate-instances i-ID

http://code.google.com/p/appscale/wiki/ImageSetupViaBzr


It's possible to start appscale by defining an app (clone the sample-apps repo and cd in to the python directory) on the command line, or starting a cloud and then uploading an app.

Pre-baked AppScale AMI: ami-52912a3b

Use ``--test`` to set the credentials to ``a@a.a`` and password ``aaaaaa``

Without app:: 

    AMI=ami-52912a3b
    appscale-run-instances --infrastructure ec2 --keyname appscaleXXX --min 1 --max 1 --machine ${AMI} -v  # the keyname should be a new keyname, not one you?ve used or created previously

Now upload an app::

    cd ${APPSCALE_SAMPLE_APPS}/python
    appscale-upload-app --keyname appscaleXXX --file guestbook # guestbook is the best supported app ATM

Defining an app::

    appscale-run-instances --infrastructure ec2 --keyname appscaleXXX --min 1 --max 1 --machine ami-ddbb3cb4 --file guestbook -v

When you're done::

    appscale-terminate-instances --keyname appscaleXXX
