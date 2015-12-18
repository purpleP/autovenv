import subprocess
from unittest import TestCase


class VenvTest(TestCase):

    def test_path_within_another(self):
        outer_folder = '/foo'
        inner_folder = '/foo/bar'
        self.assertEquals(self.call(outer_folder, inner_folder), b'down\n')
        self.assertEquals(self.call(inner_folder, outer_folder), b'up\n')
        self.assertEquals(self.call(inner_folder, inner_folder), b'nowhere\n')

    def call(self, from_path, to_path):
        command = '. ./new_auto.sh; where_are_we_going {} {}'.format(from_path, to_path)
        return subprocess.check_output(['zsh', '-c', command])




