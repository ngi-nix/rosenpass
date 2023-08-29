{rosenpassPkg, ...}: {
  name = "rosenpass tests";

  nodes = {
    server = {
      pkgs,
      config,
      ...
    }: {
      environment.systemPackages = [rosenpassPkg];

      # Use kmscon <https://www.freedesktop.org/wiki/Software/kmscon/>
      # to provide a slightly nicer console, and while we're at it,
      # also use a nice font.
      # With kmscon, we can for example zoom in/out using [Ctrl] + [+]
      # and [Ctrl] + [-]
      services.kmscon = {
        enable = true;
        fonts = [
          {
            name = "Fira Code";
            package = pkgs.fira-code;
          }
        ];
      };
    };
  };

  testScript = {nodes, ...}: ''
    start_all()

    with subtest("rosenpass"):
        # server.execute("pretalx create_test_event")

        server.succeed("echo Hello World!")
  '';
}
