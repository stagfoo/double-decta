function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end


function fish_prompt
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l red (set_color -o red)
  set -l yellow (set_color -o yellow)

  set_color $fish_color_cwd

  printf "$yellow╔▧"
  if [ -n "$SSH_CONNECTION" ]
    printf '%s | ' (hostname | head -c 10)" "
  end
  if [ (_git_branch_name) ]
      printf "$green ⊶ "(_git_branch_name)" "
  end
  if [ (_git_branch_name) ]
    if [ (_is_git_dirty) ]
        printf "$red⍉"
      else
        printf "$red◍"
      end
  end
  printf " "$blue(pwd | grep -o '[^/]*$')
  printf "\n"
  printf "$yellow╚▧ "

end
