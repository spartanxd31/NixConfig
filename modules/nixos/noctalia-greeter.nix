{ config, pkgd, ... }:
{
  programs.noctalia-greeter = {
    enable = true;
    # Optional: extra flags after `--` on noctalia-greeter-session
    greeter-args = "";
    # Full declarative greeter.toml (overwritten each activation). See examples/greeter.toml.
  };
}
