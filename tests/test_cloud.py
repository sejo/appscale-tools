import unittest

from mock import Mock, patch

from appscaletools import cloud


class CloudTestCase(unittest.TestCase):
    @patch('appscaletools.cloud.EC2Connection')
    def setUp(self, connection_mock):
        self.connection_mock = connection_mock

        self.name = 'foo'
        self.cloud = cloud.Cloud(self.name)

    def test_terminate(self):
        self.cloud.terminate_instances = Mock()
        self.cloud.remove_key_pair = Mock()
        self.cloud.remove_group = Mock()

        self.cloud.terminate()

        self.cloud.terminate_instances.assert_called_with()
        self.cloud.remove_key_pair.assert_called_with()
        self.cloud.remove_group.assert_called_with()

    def test_terminate_instances(self):
        mock = self.cloud.connection

        # create two instances, one that matches the name 'foo' and one that does not
        instance1 = Mock()
        instance1.key_name = 'foo'
        instance2 = Mock()
        instance2.key_name = 'bar'

        # create a reservation with the two instances above
        reservation_mock = Mock()
        reservation_mock.instances = [instance1, instance2]

        mock.get_all_instances.return_value = [reservation_mock]

        self.cloud.terminate_instances()

        # make sure that only the foo instance was terminated
        instance1.terminate.assert_called_with()
        self.assertEqual(False, instance2.terminate.called)

    def test_remove_group(self):
        mock = self.cloud.connection

        # create two groups, one that matches the name 'foo' and one that does not
        group1 = Mock()
        group1.name = 'foo'
        group2 = Mock()
        group2.name = 'bar'

        mock.get_all_security_groups.return_value = [group1, group2]

        self.cloud.remove_group()

        # make sure that only the foo instance was terminated
        group1.delete.assert_called_with()
        self.assertEqual(False, group2.delete.called)

    def test_remove_key_pair(self):
        mock = self.cloud.connection

        # create two groups, one that matches the name 'foo' and one that does not
        keypair1 = Mock()
        keypair1.name = 'foo'
        keypair2 = Mock()
        keypair2.name = 'bar'

        mock.get_all_key_pairs.return_value = [keypair1, keypair2]

        self.cloud.remove_key_pair()

        # make sure that only the foo instance was terminated
        keypair1.delete.assert_called_with()
        self.assertEqual(False, keypair2.delete.called)
