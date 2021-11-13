data:extend({
  {
    type = "bool-setting",
    name = "nco-RCONCompanion-clock",
    order = "aa",
    setting_type = "runtime-global",
    default_value = true,
  },
    {
    type = "int-setting",
    name = "nco-RCONCompanion-clock_update-timeout",
    order = "ab",
    setting_type = "runtime-global",
    default_value = 6,
    minimum_value = 1, -- 1m
    maximum_value = 60, -- 1h
  },
})