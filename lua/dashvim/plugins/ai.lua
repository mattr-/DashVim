return {
  -- integrate with GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    build = ":Copilot auth",
    cmd = "Copilot",
    event = "BufReadPost",
  },
}
