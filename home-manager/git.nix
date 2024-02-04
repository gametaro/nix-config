{pkgs, ...}: {
  programs = {
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        prompt = "enabled";
        aliases = {
          co = "pr checkout";
          s = "status";
        };
      };
    };
    git = {
      enable = true;
      userName = "Kotaro Yamada";
      userEmail = "32237320+gametaro@users.noreply.github.com";
      difftastic.enable = true;
      extraConfig = {
        branch.autoSetupRebase = "always";
        commit = {
          gpgSign = true;
          verbose = true;
        };
        diff.renames = "copy";
        fetch = {
          prune = true;
          writeCommitGraph = true;
        };
        gpg = {
          format = "ssh";
          "ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
        };
        init.defaultBranch = "main";
        merge.conflictStyle = "zdiff3";
        mergetool.keepBackup = false;
        pull.rebase = true;
        push = {
          autoSetupRemote = true;
          followTags = true;
        };
        rebase = {
          autoSquash = true;
          autoStash = true;
          stat = true;
          updateRefs = true;
        };
        rerere = {
          autoUpdate = true;
          enabled = true;
        };
        status.showUntrackedFiles = "all";
        tag.gpgSign = true;
        user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKfA4i4/FZSyrYZRHPbnzQHRyMlGdJwPxKQRhFucf6h";
      };
    };
  };
}
