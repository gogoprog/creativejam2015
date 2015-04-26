return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.11.0",
  orientation = "orthogonal",
  width = 8,
  height = 8,
  tilewidth = 96,
  tileheight = 96,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 96,
      tileheight = 96,
      spacing = 0,
      margin = 0,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tiles = {
        {
          id = 0,
          image = "start.png",
          width = 96,
          height = 96
        },
        {
          id = 1,
          image = "end.png",
          width = 96,
          height = 96
        },
        {
          id = 2,
          image = "obstacle.png",
          width = 96,
          height = 96
        },
        {
          id = 3,
          image = "bonus.png",
          width = 96,
          height = 96
        },
        {
          id = 4,
          image = "insect.png",
          width = 96,
          height = 96
        },
        {
          id = 5,
          image = "polution.png",
          width = 96,
          height = 96
        },
        {
          id = 6,
          image = "rock1.png",
          width = 96,
          height = 96
        },
        {
          id = 7,
          image = "rock2.png",
          width = 96,
          height = 96
        },
        {
          id = 8,
          image = "rock3.png",
          width = 96,
          height = 96
        },
        {
          id = 9,
          image = "rock4.png",
          width = 96,
          height = 96
        },
        {
          id = 10,
          image = "ruins_bottom.png",
          width = 96,
          height = 96
        },
        {
          id = 11,
          image = "ruins_corner_b_l.png",
          width = 96,
          height = 96
        },
        {
          id = 12,
          image = "ruins_corner_b_r.png",
          width = 96,
          height = 96
        },
        {
          id = 13,
          image = "ruins_corner_t_l.png",
          width = 96,
          height = 96
        },
        {
          id = 14,
          image = "ruins_corner_t_r.png",
          width = 96,
          height = 96
        },
        {
          id = 15,
          image = "ruins_full.png",
          width = 96,
          height = 96
        },
        {
          id = 16,
          image = "ruins_left.png",
          width = 96,
          height = 96
        },
        {
          id = 17,
          image = "ruins_right.png",
          width = 96,
          height = 96
        },
        {
          id = 18,
          image = "ruins_top.png",
          width = 96,
          height = 96
        },
        {
          id = 19,
          image = "ruins_strip_end_b.png",
          width = 96,
          height = 96
        },
        {
          id = 20,
          image = "ruins_strip_end_l.png",
          width = 96,
          height = 96
        },
        {
          id = 21,
          image = "ruins_strip_end_r.png",
          width = 96,
          height = 96
        },
        {
          id = 22,
          image = "ruins_strip_end_t.png",
          width = 96,
          height = 96
        },
        {
          id = 23,
          image = "ruins_strip_h.png",
          width = 96,
          height = 96
        },
        {
          id = 24,
          image = "ruins_strip_v.png",
          width = 96,
          height = 96
        },
        {
          id = 25,
          image = "ruins_angle_b_l.png",
          width = 96,
          height = 96
        },
        {
          id = 26,
          image = "ruins_angle_b_r.png",
          width = 96,
          height = 96
        },
        {
          id = 27,
          image = "ruins_angle_t_l.png",
          width = 96,
          height = 96
        },
        {
          id = 28,
          image = "ruins_angle_t_r.png",
          width = 96,
          height = 96
        },
        {
          id = 29,
          image = "ruins_bridge_b.png",
          width = 96,
          height = 96
        },
        {
          id = 30,
          image = "ruins_bridge_l.png",
          width = 96,
          height = 96
        },
        {
          id = 31,
          image = "ruins_bridge_r.png",
          width = 96,
          height = 96
        },
        {
          id = 32,
          image = "ruins_bridge_t.png",
          width = 96,
          height = 96
        },
        {
          id = 33,
          image = "ruins_strip_corner_b_l.png",
          width = 96,
          height = 96
        },
        {
          id = 34,
          image = "ruins_strip_corner_b_r.png",
          width = 96,
          height = 96
        },
        {
          id = 35,
          image = "ruins_strip_corner_t_l.png",
          width = 96,
          height = 96
        },
        {
          id = 36,
          image = "ruins_strip_corner_t_r.png",
          width = 96,
          height = 96
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 8,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 7, 2, 0, 0, 0,
        0, 0, 21, 24, 24, 24, 22, 0,
        23, 0, 0, 4, 6, 0, 0, 0,
        37, 24, 22, 0, 0, 0, 6, 23,
        0, 0, 5, 0, 6, 23, 0, 25,
        21, 22, 8, 0, 0, 20, 0, 25,
        0, 0, 0, 0, 0, 0, 0, 25,
        0, 0, 1, 21, 24, 24, 24, 36
      }
    }
  }
}
