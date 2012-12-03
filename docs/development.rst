Development
===========

There are a couple tools configured for developing AppScale Tools with Python:
``nose`` and ``pylint``.  Nose is a test runner that is invoked using the
``nosetests`` command.  Nose will automatically find and run any tests it can
find.  Initial tests have been placed in the ``tests`` directory.

Pylint is a "linter", which helps the code free of syntax and formatting
convention errors.  Before pushing code upstream, make sure to run pylint in
order to catch errors and keep code consistent.
