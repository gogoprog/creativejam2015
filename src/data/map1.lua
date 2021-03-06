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
        0, 0, 2, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 14, 19, 15, 0, 0, 0,
        0, 0, 17, 16, 18, 0, 0, 0,
        0, 0, 12, 11, 13, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 1, 0, 0, 0
      }
    }
  }
}
