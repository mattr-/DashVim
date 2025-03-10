return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "norg", "rmd", "org", "codecompanion" },
    opts = {
      render_modes = true,
      heading = {
        border = false,
        position = "inline",
        icons =  { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        left_pad = 1,
        sign = false,
      },
      code = {
        style = "normal",
      },
      checkbox = {
        enabled = true,
        custom = {}, --disable the default custom checkboxes
      },
      pipe_table = {
        preset = "heavy",
      },
    },
  },
}
