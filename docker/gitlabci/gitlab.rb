external_url 'https://gitlab.morozovme.com/'
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab_root_password')
