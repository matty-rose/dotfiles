function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'
  __bobthefish_colors base16-dark

  set -l base00 272822
  set -l base01 383830
  set -l base02 49483e
  set -l base03 75715e
  set -l base04 a59f85
  set -l base05 f8f8f2
  set -l base06 f5f4f1
  set -l base07 f9f8f5
  set -l base08 f92672 # red
  set -l base09 fd971f # orange
  set -l base0A f4bf75 # yellow
  set -l base0B a6e22e # green
  set -l base0C a1efe4 # cyan
  set -l base0D 66d9ef # blue
  set -l base0E ae81ff # violet
  set -l base0F cc6633 # brown

  set -l colorfg $base02

  set -x color_initial_segment_exit     $base01 $base08 --bold
  set -x color_initial_segment_private  $base01 $base04 --bold
  set -x color_initial_segment_su       $base01 $base0B --bold
  set -x color_initial_segment_jobs     $base01 $base0D --bold

  set -x color_path                     $base02 $base05
  set -x color_path_basename            $base02 $base06 --bold
  set -x color_path_nowrite             $base02 $base09
  set -x color_path_nowrite_basename    $base02 $base09 --bold

  set -x color_repo                     $base0B $colorfg
  set -x color_repo_work_tree           $base02 $colorfg --bold
  set -x color_repo_dirty               $base08 $base05
  set -x color_repo_staged              $base09 $colorfg

  set -x color_vi_mode_default          $base03 $base05 --bold
  set -x color_vi_mode_insert           $base0B $colorfg --bold
  set -x color_vi_mode_visual           $base09 $colorfg --bold

  set -x color_vagrant                  $base0C $colorfg --bold
  set -x color_k8s                      005faf $base05 --bold
  set -x color_aws_vault                $base0D $colorfg --bold
  set -x color_aws_vault_expired        $base0D $base08 --bold
  set -x color_username                 632fc4 $base05 --bold
  set -x color_hostname                 $base02 $base0D
  set -x color_rvm                      $base08 $base05 --bold
  set -x color_nvm                      $base0B $colorfg --bold
  set -x color_virtualfish              $base0D $colorfg --bold
  set -x color_virtualgo                $base0D $colorfg --bold
  set -x color_desk                     $base0D $colorfg --bold
  set -x color_nix                      $base0D $colorfg --bold
end
