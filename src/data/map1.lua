return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.11.0",
  orientation = "orthogonal",
  width = 6,
  height = 6,
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
      width = 6,
      height = 6,
      visible = true,
      opacity = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 2, 0, 0, 0,
        0, 0, 0, 0, 5, 0,
        0, 0, 3, 3, 4, 0,
        0, 0, 3, 3, 0, 6,
        0, 5, 0, 0, 0, 0,
        0, 0, 0, 1, 0, 0
      }
    }
  }
}
