import errno
from os import fsync, makedirs
from os.path import join, basename
import re

from django.conf import settings
from django.http import HttpResponse

node_id_matcher = re.compile(r'OW[0-9A-F]{12}$')

uploader_modules = {
    'active': 1 * 2**20,
    'bismark-experiments-manager': 10 * 2**20,
    'bismark-updater': 10 * 2**20,
    'mac-analyzer': 10 * 2**20,
    'nazanin-traceroute': 10 * 2**20,
    'passive': 10 * 2**20,
    'passive-frequent': 100 * 2**10,
    'web100-test': 100 * 2**10,
    'wifi-beacons': 10 * 2**20,
}

def upload(request):
    module = request.REQUEST['directory']
    if module not in uploader_modules:
        raise ValueError('Invalid module')
    if len(request.raw_post_data) > uploader_modules[module]:
        raise ValueError('Upload is too big')
    if node_id_matcher.match(request.REQUEST['node_id']) is None:
        raise ValueError('Invalid node id')

    path = join(settings.UPLOADS_ROOT, module, request.REQUEST['node_id'])
    try:
        makedirs(path)
    except OSError, e:
        if e.errno != errno.EEXIST:
            raise
    handle = open(join(path, basename(request.REQUEST['filename'])), 'w')
    handle.write(request.raw_post_data)
    handle.flush()
    fsync(handle.fileno())
    handle.close()

    return HttpResponse('done')
