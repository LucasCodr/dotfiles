import { $ } from "bun";

async function isInstalled(program: string) {
  const cmd = await $`which ${program}`.nothrow().text();

  if (cmd.includes('not found')) {
    return false
  }

  return true
}

const isNVMInstalled = await $`cat ~/.bashrc | grep NVM_DIR`.nothrow().text().then(Boolean);

if (!isNVMInstalled) {
  await $`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash`;
} else {
  console.log('NVM is installed.')
}

const npm = await isInstalled('npm')

if (!npm) {
  console.log('Installing npm...')

  await $`nvm install --lts`

  console.log('NVM and node installed.')
} else {
  console.log('npm/node installed')
}

const isZshInstalled = await isInstalled('zsh')

if (!isZshInstalled) {
  console.log('Installing zsh...')
  await $`sudo pacman -S zsh`
} else {
  console.log('ZSH is installed.')
}

try {
  await $`cat ~/.zshrc`.quiet();
  console.log('oh my zsh is installed')
} catch {
  console.log('Installing oh-my-zsh')
  await $`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`;
}


try {
  await $`cat ~/.zshrc | grep zinit`.quiet();
  console.log('zinit is installed')
} catch {
  console.log('Installing zinit')
  await $`bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"`;
}
