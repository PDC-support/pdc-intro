episodes = {
    'infrastructure.md': 'Background and infrastructure',
    'accounts.md': 'Accounts, login, and file system',
    'bash.md': 'Using Bash shell',
    'compile-on-cpu.md': 'Compiling and running code on CPU nodes',
    'job-script.md': 'Job script for efficient utilization of hardware',
    'thinlinc.md': 'Using ThinLinc',
    'compile-on-gpu.md': 'Compiling and running code on GPU nodes',
    'singularity.md': 'Using Singularity',
    'matlab.md': 'Using Matlab',
    'mattheocodes.md': 'Materials theory codes',
    'python-env.md': 'Using Python virtual environment',
}

episode_lines = []
episode_starting_page = {}
page_count = 0

for ep_name, ep_title in episodes.items():
    with open(ep_name, 'r') as fh:
        lines = fh.readlines()

    episode_lines += lines
    episode_starting_page[ep_name] = (page_count + 3)

    for line in lines:
        if line.strip() == '---':
            page_count += 1

with open('../PITCHME.md', 'w') as f_pitchme:
    with open('title.md', 'r') as fh:
        for line in fh:
            f_pitchme.write(line)
            if line.strip() == '# Contents':
                break
    f_pitchme.write('\n')

    for ep_name, ep_page in episode_starting_page.items():
        f_pitchme.write(f'* [{episodes[ep_name]}](#{ep_page})\n')
    f_pitchme.write('\n')

    for line in episode_lines:
        f_pitchme.write(line)
